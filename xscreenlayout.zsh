#!/usr/bin/env zsh
##########################################
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣  -NAME:	xscreenlayout.zsh
## ╚  ╩╩═╝╚═╝           ''''''''''''''''
##	 -PATH:    	/home/zsh/
##	 -STATUS:	work in progress
##	 -USAGE:	RC-File for zsh 
## -------------------------------------
# FILE DATES	[yyyy-mmm-dd]
##..SAVE:	  	2024-feb-23
##..CREATION:   2023
## -----------------------------------------
## AUTHOR:		mxx
## COMMENTS: 	
###########################################

# Farbdefinitionen
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
RED="\033[38;2;128;0;0m\033[48;2;255;160;160m"
NC="\033[0m"

# Funktion zur Verarbeitung des xrandr-Layouts
process_xrandr_layout() {
  if [[ -e "$XDG_CONFIG_HOME/screenlayout/current-setting.sh" ]]; then
    zsh -c "$XDG_CONFIG_HOME/screenlayout/current-setting.sh" && {
      echo -e "${GREEN}xrandr erfolgreich über $XDG_CONFIG_HOME/screenlayout config ausgeführt${NC}" | clolcat
      xcowsay --image="$HOME/Bilder/nixOS-logo.png" --time=3 --at=1200,200 --monitor=0 --left --font=unifont "xrandr erfolgreich über $XDG_CONFIG_HOME/screenlayout config ausgeführt"
    }
  else
    echo -e "${RED}$XDG_CONFIG_HOME/screenlayout/current-setting.sh nicht vorhanden${NC}" | clolcat
  fi
}

# Prüfe die Session-Typen und führe entsprechende Aktionen aus
case "$XDG_SESSION_TYPE" in
  x11)
    # Verarbeite das xrandr-Layout
    process_xrandr_layout
    ;;
  wayland)
    # Gib eine Meldung aus, dass xrandr bei Wayland nicht möglich ist
    echo -e "${RED}WAYLAND, deshalb ist xrandr nicht möglich${NC}"
    ;;
  *)
    # Gib eine Meldung aus, dass der Session-Typ unbekannt ist
    echo -e "${RED}Unbekannter Session-Typ: $XDG_SESSION_TYPE${NC}"
    ;;
esac


