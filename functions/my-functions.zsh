#!/usr/bin/env zsh

# auth:        _______max_kempter_________
# filename:    _______my-function.zsh_____

SKY="\033[38;2;62;36;129m\033[48;2;135;206;235m"
RED="\033[38;2;240;128;128m\033[48;2;139;0;0m"
RASPBERRY="\033[38;2;32;0;21m\033[48;2;221;160;221m"
RESET="\033[0m"

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
#_______________________________________________________________
WO() {
    # Überprüfen, ob ein Argument übergeben wurde
   if [ -z "$1" ]; then
       echo -e "${PINK}Bitte einen Befehl angeben.${RESET}"
        return 1
    fi
# Zeige die Nachricht an
    echo -e "${PINK}nixOS ONLY:${RESET}${SKY} \
    Zeigt den Path zu dem Befehl, auf den verwiesen wird:${RESET}\n"
# Führen Sie die Befehle aus und zeigen Sie die Ergebnisse an
    echo -e "${PINK}\twhich -s "$1" ${RESET}"
    which -s "$1"

    echo -e "${PINK}\treadlink -f $(which $1) ${RESET}"
    du -ah $(readlink -f "$(which "$1")")
}

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
NIXempty() {
    # Color definitions
    local GREEN='\033[0;32m'
    local RED='\033[0;31m'
    local YELLOW='\033[1;33m'
    local CYAN=${CYAN}
    local BLUE=${NIGHT}
    local PINK=${PINK}
    local NC='\033[0m' # No Color

    # ASCII header
    echo -e "${PINK}\t____________________________________________________"
    echo -e "${CYAN}\t______________________________________________________"
    echo -e "\t/_____/_____/_____/_____/_____/_____/_____/_____/_____/"
    echo -e "\t         _____/ /__  ____ _____  ___  _____     "
    echo -e "\t        / ___/ / _ \/ __ // __ \/ _ \/ ___/     "
    echo -e "\t      / /__/ /  __/ /_/ / / / /  __/ /    "
    echo -e "\t      \___/_/\___/\__,_/_/ /_/\___/_/    "
    echo -e "\t______________________________________________________"
    echo -e "\t_/_____/_____/_____/_____/_____/_____/_____/_____/_____/"
    echo -e "${PINK}\n\t=== Nix Store Cleaner ===${NC}"
    echo -e "${CYAN}\t____________________________________________________\n"

    # Check required tools (bypassing aliases)
    local missing=()
    local required_cmds=(du numfmt sudo nix-collect-garbage nix-store)
    for cmd in "${required_cmds[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done

    if (( ${#missing[@]} > 0 )); then
        echo -e "${RED}❌ Missing required commands:${NC} ${missing[*]}"
        return 1
    fi

    # Get Nix store size (safe numeric parsing)
    echo -e "${YELLOW}🔍 Checking Nix store size before cleanup...${NC}"
    local before_bytes
    before_bytes=$(command sudo du -sb /nix/store 2>/dev/null |awk '{print $1}')

    # Validate numeric result
    if ! [[ "$before_bytes" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}❌ Error: Could not determine store size${NC}"
        echo -e "${YELLOW}ℹ️ Try running manually: sudo du -sb /nix/store${NC}"
        return 1
    fi

    local before_hr
    before_hr=$(numfmt --to=iec --suffix=B "$before_bytes")
    echo -e "Current Nix store size: ${BLUE}${before_hr}${NC}"

    # Safety confirmation
    echo -e "\n${RED}⚠️ WARNING: This will permanently delete unused Nix packages!${NC}"
    if [[ -n "$ZSH_VERSION" ]]; then
        read -q "REPLY?❓ Proceed with cleanup? (y/N) "
        echo
    else
        read -r -p "❓ Proceed with cleanup? (y/N) " REPLY
    fi

    if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
        echo -e "\n${RED}❌ Cleanup canceled. No changes were made.${NC}"
        return 0
    fi

    echo -e "\n${GREEN}🚀 Starting cleanup...${NC}"

    # 1. Remove auto GC roots (with alias bypass)
    local auto_roots="/nix/var/nix/gcroots/auto"
    if [[ -d "$auto_roots" ]]; then
        echo -e "${YELLOW}⏳ Removing old GC roots from ${auto_roots}...${NC}"
        local count
        count=$(command sudo find "$auto_roots" -mindepth 1 -maxdepth 1 -print | wc -l)
        if (( count > 0 )); then
            time (command sudo find "$auto_roots" -mindepth 1 -maxdepth 1 -delete)
            echo -e "${BLUE}Removed ${count} GC roots${NC}"
        else
            echo -e "${BLUE}No GC roots found to remove${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️ GC roots directory missing: ${auto_roots}${NC}"
    fi

    # 2. Run garbage collection (bypassing aliases)
    echo -e "\n${YELLOW}⏳ Running nix-collect-garbage -d...${NC}"
    time command sudo nix-collect-garbage -d

    # 3. Optimize store
    echo -e "\n${YELLOW}⏳ Optimizing Nix store...${NC}"
    time command sudo nix-store --optimise

    # Get post-cleanup size
    local after_bytes
    after_bytes=$(command sudo du -sb /nix/store 2>/dev/null | awk '{print $1}')

    # Validate result
    if ! [[ "$after_bytes" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}❌ Error: Could not verify new store size${NC}"
        after_bytes="$before_bytes"
    fi

    # Calculate savings
    local saved_bytes=$((before_bytes - after_bytes))
    if (( saved_bytes < 0 )); then
        saved_bytes=0
    fi
    local after_hr saved_hr
    after_hr=$(numfmt --to=iec --suffix=B "$after_bytes")
    saved_hr=$(numfmt --to=iec --suffix=B "$saved_bytes")

    # Results summary
    echo -e "\n${CYAN}📊 Results:${NC}"
    echo -e "New Nix store size: ${BLUE}${after_hr}${NC}"
    echo -e "\n${PINK}🎉 Cleanup complete!${NC}"
    echo -e "${GREEN}👉 Saved space: $saved_hr  (${before_hr} →${after_hr})${NC}"

    # Desktop notification
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Nix Cleaner" "Freed $saved_hr\nNew size: $after_hr" --icon=package
    fi
}
alias Nempty=NIXempty
alias NIXclean=NIXempty
alias Nclean=NIXempty

