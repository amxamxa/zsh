#!/usr/bin/env sh
# auth:        _______max_kempter_________
# filename:    _______my-function.zsh_____

SKY="\033[38;2;62;36;129m\033[48;2;135;206;235m"
RED="\033[38;2;240;128;128m\033[48;2;139;0;0m"
RASPBERRY="\033[38;2;32;0;21m\033[48;2;221;160;221m"
PINK="\033[38;2;32;0;21m\033[48;2;163;64;217m"
VIO="\033[38;2;255;0;53m\033[48;2;34;0;82m"
ORA="\033[38;2;0;17;204m\033[48;2;255;140;0m";
RESET="\033[0m"

WO() {
    # --- Argument check
    if [ -z "${1:-}" ]; then
        echo "${PINK}Please provide a command name.${RESET}\n"
        return 1
    fi

    cmd="$1"

    # --- Header
    echo "\t ${ORA}NixOS ONLY:${RESET}"
    echo "${SKY} Showing resolved command path, Nix package, and file details.${RESET}\n"

    # --- Resolve via command -v
    cmd_path="$(command -v -- "$cmd" 2>/dev/null || true)"

    if [ -z "$cmd_path" ]; then
        echo "${PINK}Command not found: ${cmd}${RESET}/n"
        return 2
    fi

    echo "${PINK}Resolved via 'command -v':${RESET} $cmd_path"

    # Builtin/function/alias?
    case "$cmd_path" in
        /*) ;; 
        *)
            echo "${PINK}Note:${RESET} This command is a shell builtin, function, or alias."
            return 0
            ;;
    esac

    # --- Resolve symlinks (GNU readlink -f)
    real_path="$(command readlink -f -- "$cmd_path" 2>/dev/null)"
    echo "${ORA}Final resolved file path w/ readlink -f :${RESET} $real_path"

    # --- Nix package derivation (NEW)
    echo "${PINK}Nix package derivation:${RESET}"

    if echo "$real_path" | command grep -q '^/nix/store/'; then
        store_path="$(echo "$real_path" | cut -d/ -f1-4)"
        echo "${BOLD} Store path: $store_path${RESET} "

        # Bindings: derivation info
        if command -v nix-store >/dev/null 2>&1; then
            drv="$(nix-store -q --binding drvPath "$store_path" 2>/dev/null || true)"
            out="$(nix-store -q --binding outPath "$store_path" 2>/dev/null || true)"

            echo "  Derivation:  $drv"
            echo "  Output path: $out"
        else
            echo "  nix-store not found in PATH.\n"
        fi
    else
        echo "  This is NOT a Nix store binary.\n"
    fi

    # --- Size
    echo "\n${VIO}File size (du -h):${RESET}"
    command du -h -- "$real_path" 2>/dev/null || true

#  echon' "${PINK}COMMAND TYPE W/ "type -w CMD; type -s CMD ":${RESET}"
 #   command du -h -- "$real_path" 2>/dev/null || true


    # --- Metadata
    if command -v stat >/dev/null 2>&1; then
        echo "\n${PINK}File metadata (stat):${RESET}"
       command stat --format='Size: %s bytes | Mode: %a | File: %N' -- "$real_path" 2>/dev/null
    fi

    return 0
}




#________________________________________________

BKP() {
# Skript erstellt Backup-Dateien oder -Verzeichnisse mit einem Zeitstempel 
# im Namen. Es unterstützt:
# - **Prüfung auf `xcp` oder `cp`**: Verwendet `xcp` für effizienteres Kopieren, falls verfügbar. Falls nicht, wird `cp` verwendet. Gibt eine Fehlermeldung aus, wenn beide Befehle fehlen.
# - **Rekursive Verarbeitung**: Unterstützt die Verarbeitung von Verzeichnissen und deren Unterinhalten.
# - **Fehlermeldungen und Warnungen**: Informiert, wenn ungültige Dateien/Verzeichnisse übergeben wurden.
  
 # Prüfe, ob xcp oder cp verfügbar ist
 if command -v xcp >/dev/null 2>&1; then
        copy_command="xcp --verbose"
    elif command -v cp >/dev/null 2>&1; then
        copy_command="cp -i --verbose"
    else
        echo "Fehler: Weder 'xcp' noch 'cp' ist verfügbar. Bitte installiere eines von beiden." >&2
        return 1
 fi

    # Funktion zur rekursiven Verarbeitung von Dateien und Verzeichnissen
 process_file_or_directory() {
     local file="$1"
     if [ -d "$file" ]; then
            # Verzeichnis -> rekursiv alle Dateien verarbeiten
        for subfile in "$file"/*; do
                process_file_or_directory "$subfile"
         done
        elif [ -f "$file" ]; then
            # Datei -> Backup erstellen
            filename=$(basename -- "$file")
            extension="${filename##*.}"
            name="${filename%.*}"
            $copy_command "$file" "${name}.$(date +%Y-%m-%d).bkp.${extension}"
        else
           echo "Warnung: '$file' ist weder eine Datei noch ein Verzeichnis, überspringe." >&2
       fi
    }
    # Verarbeite alle übergebenen Argumente
    for file in "$@"; do
        process_file_or_directory "$file"
    done
}
#_______________________________________________________________
NIXcopy() {
    local destination_dir="/share/nixos/bkp/$(date +%F)"
    mkdir -p "$destination_dir"
    xcp --verbose /etc/nixos/*.nix "$destination_dir/"
}
#_____________________________
#---------------------------------
bap-NoComment() {
    # Überprüfen, ob ein Dateiname übergeben wurde
    if [[ -z "$1" ]]; then
        echo "Bitte einen Dateinamen angeben."
        return 1
    fi

    # Überprüfen, ob die Datei existiert
    if [[ ! -f "$1" ]]; then
        echo "Die Datei '$1' existiert nicht."
        return 1
    fi

    # Überprüfen, ob `bat` installiert ist
    if ! command -v bat > /dev/null 2>&1; then
        echo "Das Tool 'bat' ist nicht installiert. Bitte installieren und erneut versuchen."
        return 1
    fi

    # Datei mit bat ausgeben, Kommentare entfernen
   command bat --color=always --language=zsh -p "$1" | awk '
        BEGIN { in_string = 0 }
        {
            # Überprüfen, ob wir uns in einem String befinden
            for (i = 1; i <= length($0); i++) {
                char = substr($0, i, 1)

                # Umschalten bei Stringbeginn oder -ende
                if (char == "\"" && (i == 1 || substr($0, i - 1, 1) != "\\")) {
                    in_string = !in_string
                }

                # Nur Kommentare entfernen, die nicht in Strings stehen
                if (!in_string && char == "#") {
                    $0 = substr($0, 1, i - 1) # Kommentar abschneiden
                    break
                }
            }
        }
        NF { print } # Nur nicht-leere Zeilen ausgeben
    '
}
	#_____________________________________
Htop() {
    local max_lines=${1:-25}
    
    history 0 | 
    awk '{print $2}' | 
    sort | 
    uniq -c | 
    sort -k1,1rn -k2 | 
    head -n "$max_lines" | 
    while read count cmd; do
        printf "${SKY}%s${RASPBERRY} %s${RESET}\n" "$count" "$cmd"
    done
}
	#_________________________

PROspeed() {
# Display the time for the prompt to appear when opening a new zsh instance
     for i in $(seq 1 10); do /run/current-system/sw/bin/time zsh -i -c exit; done
        }
#	________________________________________________________________________________________

NETports() {
# List of port opens, fuzzy searchable via fzf
     sudo netstat -tulpn | grep LISTEN | fzf;
        }
#	________________________________________________________________________________________

# cheat() {
# Display command cheatsheet from [cheat.sh](https://github.com/Phantas0s/.dotfiles/blob/master/zsh/cheat.sh).
    # curl cht.sh/:help
  #   curl cheat.sh/$1
     # &style=fruity'
#styles: paraiso-dark
#       }
#	________________________________________________________________________________________

###############################################################################
# Generate a m3u files with same filename as directories passed as arguments.
# The file is written with all files in each arg.
# Example: cm3u KIZ,  create a file 'kiz.m3u' 
GENplaylist() {
    for file in "$@"
    do
        if [ -d $file ]; then
            m3u="$file.m3u"
            find "$file" -type f > "$m3u"
        else
            echo "'$file' should be the directory where all your files are"
        fi
    done
            }
#_________________________________________________________________________________________
TRASH() {
    if [ -d "$HOME/.local/share/Trash" ]; then 
        printf "${GELB}Sind Sie sicher, dass Sie alle Dateien im Trash löschen möchten? (j/n):${RESET} "
        read answer
        case $answer in
            [Jj]* )
                command rm --recursive --one-file-system --force $HOME/.local/share/Trash/*
                echo -e "${GREEN}Alles gelöscht.${RESET}"
                ;;
            * )
                echo -e "${YELLOW}Aktion abgebrohen.${RESET}"
                ;;
        esac
    else 
        echo -e "${YELLOW}Trash-Verzeichnis existiert nicht.${RESET}"
    fi
}

## ---------------------------------------------------------------------------------------
#	   SET RANDOM TERMINAL COLOR THEME
color-theme-switch() {
  # Überprüfen, ob die Datei existiert
    if [[ ! -f "$ZDOTDIR/color-theme.md" ]]; then
        echo "Fehler: Datei $ZDOTDIR/color-theme.md nicht gefunden."
        return 1
    fi
  	# Anzahl der Zeilen in .theme_history
    num_themes=$(wc -l < "$ZDOTDIR/color-theme.md")
 	 # Generiere eine zufällige Zahl zwischen 1 und der Anzahl der Themes
    random_num=$((1 + RANDOM % num_themes))
  	# Hole das Theme an der zufälligen Zeilennummer
    selected_theme=$(sed -n "${random_num}p" < "$ZDOTDIR/color-theme.md")
  	# Setze das ausgewählte Theme
    echo -e "${PINK} Setting terminal theme to: $selected_theme ${RESET}"
    command theme.sh $selected_theme
}

### ------------------------------------------------- ###
#  	Funktion COPYto .... aliases.maybe  
#    Speichert den letzten Befehl in die Datei 
# $ZDOTDIR/aliases.maybe und gibt eine Bestätigungsmeldung aus.
### ------------------------------------------------- ###
COPYtoZ() {
	# 'echo $(fc -ln -1)' gibt den letzten Befehl aus.
	# 'tee -a $ZDOTDIR/aliases.maybe' fügt den Ausgabetext an die Datei $ZDOTDIR/aliases.maybe an.
	echo $(fc -ln -1) | tee -a $ZDOTDIR/aliases.maybe
	# Überprüft, ob der letzte Befehl erfolgreich ausgeführt wurde.
	if [ $? -eq 0 ]; then
	# Wenn der Befehl erfolgreich ausgeführt wurde, gibt diese Funktion eine Bestätigungsmeldung aus.
	  echo "${GREEN}Befehl $(fc -ln -1) wurde erfolgreich an $ZDOTDIR/aliases.maybe angehängt.${RESET}"
	else
	# Wenn der Befehl fehlgeschlagen ist, gibt diese Funktion eine Fehlermeldung aus.
	echo "${ROSA}Fehler beim Anhängen des Befehls $(fc -ln -1) an $ZDOTDIR/aliases.maybe.${RESET}"
	fi
}
# ------------------------
