#!/usr/bin/env zsh
#########################################
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣     
## ╚  ╩╩═╝╚═╝           ''''''''''''''''
## 	 -NAME:  	my-functions.zsh 
##	 -PATH:    	$ZDOTDIR/functions
##	 -STATUS:	work in progress
##	 -USAGE:	
## -------------------------------------
# FILE DATES	[yyyy-mmm-dd]
##..SAVE:	  	2024-...
##..CREATION:   2024-07
## -----------------------------------------
## AUTHOR:		mxx
## COMMENTS: 	
###########################################
# 	┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  	├┤ │ │││││   │ ││ ││││└─┐
#  	└  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘
###################################calvin
function bat-noComment {
# Funktion schneidet alle COMMENTS aus File weg
# USAGE: $ bat-noComment datei.txt
    # Überprüfe, ob 'bat' installiert ist
    if ! command -v bat &> /dev/null; then
        echo "Error: 'bat' is not installed. Please install it and try again."
        return 1
    fi
    # Überprüfe, ob ein Dateiname als Argument übergeben wurde
    if [ -z "$1" ]; then
        echo "Usage: show_filtered_content <filename>"
        return 1
    fi
    # Überprüfe, ob die Datei existiert
    if [ ! -f "$1" ]; then
        echo "Error: File '$1' not found."
        return 1
    fi
    # Filtere und zeige die Datei an
    egrep -v "(^\s*$|^#)" "$1" 
    echo "alle Kommentare und Leerzeilen entfernt"
  }
  
BKP() {
    for file in "$@"; do
        # Extrahiere den Dateinamen ohne Pfad und die Erweiterung
        #  Der "basename" Befehl entfernt den Pfadteil eines Dateipfads und gibt nur den Namen der Datei zurück. Das -- Argument wird verwendet, um sicherzustellen, dass keine weiteren Argumente als Dateinamen interpretiert werden, falls $file mehrere Wörter enthält
        filename=$(basename -- "$file")
           #${variable##pattern}: Diese Syntax extrahiert den längsten Teil eines Strings vor dem Muster (pattern). In diesem Fall sucht es nach dem letzten Punkt (.) im Dateinamen und entfernt alles vor diesem Punkt. Da der Punkt selbst nicht in das Ergebnis aufgenommen wird, bleibt nur der Teil nach dem letzten Punkt übrig, also die Dateierweiterung.
        extension="${filename##*.}"   
      #${variable%pattern}: Ähnlich wie oben, aber diese Syntax entfernt den kürzesten Teil eines Strings nach dem Muster (pattern). In diesem Fall sucht es nach dem ersten Punkt (.) im Dateinamen und entfernt alles danach, einschließlich des Punktes selbst. Dadurch bleibt nur der Teil des Namens vor dem letzten Punkt übrig, also der Dateiname ohne die Erweiterung.
      name="${filename%.*}"

        # Erstelle das Backup mit dem aktuellen Datum und behalte die ursprüngliche Erweiterung bei
        cp -vi "$file" "${name}.$(date +%Y-%m-%d).bkp.${extension}"
    done
}
### -----------------------------------------------------------------------------
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
# nachfolgend Comment, da Syntax Bash-Funktion ist	
# TRASH() {
# 	    if [ -d "$HOME/.local/share/Trash" ]; then 
# 	        read -rp "Sind Sie sicher, dass Sie alle Dateien im Trash löschen möchten? (j/n): " answer
# 	        case $answer in
# 	            [Jj]* )
# 	                command rm --recursive --one-file-system --force $HOME/.local/share/Trash/*
# 	                echo -e "${GREEN}Alles gelöscht.${RESET}"
# 	                ;;
# 	            * )
# 	                echo -e "${YELLOW}Aktion abgebrochen.${RESET}"
# 	                ;;
# 	        esac
# 	    else 
# 	        echo -e "${YELLOW}Trash-Verzeichnis existiert nicht.${RESET}"
# 	    fi
## ---------------------------------------------------------------------------------------

## ---------------------------------------------------------------------------------------
#	   SET RANDOM TERMINAL COLOR THEME
term-col-theme() {
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
term-col-theme
## ---------------------------------------------------------------------------------------

### ------------------------------------------------- ###
##   Globale Suffix-Aliases erweitern
### ------------------------------------------------- ###
globalias() {
# Aliases erweitern aka sehen kann, mit Leertaste
	if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
		zle _expand_alias
		zle expand-word
	fi
	zle self-insert
}
zle -N globalias
bindkey " " globalias
# control-space to bypass completion
bindkey "^ " magic-space   
# normal space during searches       
bindkey -M isearch " " magic-space 
# sonstige Shortcuts in File ~/zsh/shortcuts.zsh

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


