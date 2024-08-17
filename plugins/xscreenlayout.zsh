#!/usr/bin/env zsh
##########################################
## ╔═╗╦╦  ╔═╗ ############################
## ╠╣ ║║  ║╣ 
## ╚  ╩╩═╝╚═╝
##	 -PATH:    	/home/zsh/
##	 -NAME:	  	xscreenlayout.zsh
##	 -STATUS:	
##	 -USAGE:	xrandr settings
## -------------------------------------
## FILE DATES	[yyyy-mmm-dd]
## .. SAVE:	  	2024-feb-23
## .. CREATION: feb 2024
## AUTHOR:		mxx
## COMMENTS: 
###########################################


# Setze Farben
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
ROT="\033[38;2;139;0;0m\033[48;2;255;182;193m"

# Überprüfe, ob .zshenv bereits ausgeführt wurde
if [[ "$__ETC_ZSHENV_SOURCED" -eq 1 ]]; then
    exit
fi

# Setze __ETC_ZSHENV_SOURCED auf 1, um zu markieren, dass .zshenv bereits ausgeführt wurde
#__ETC_ZSHENV_SOURCED=1

# Überprüfe die Art der Sitzung
if [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
    # Überprüfe, ob die Datei existiert
    if [[ -e "$XDG_CONFIG_HOME/screenlayout/current-setting.sh" ]]; then
        # Führe das Skript aus
      emulate sh -c "$XDG_CONFIG_HOME/screenlayout/current-setting.sh" && \
      echo -e "${GREEN}xrandr erfolgreich über $XDG_CONFIG_HOME/screenlayout config ausgeführt" && \     xcowsay --image="$HOME/Bilder/nixOS-logo.png" --time=3 --at=1200,200 --monitor=0 --left --font=unifont "xrandr erfolgreich über $XDG_CONFIG_HOME/screenlayout config ausgeführt"
    else
        echo -e "${ROT}Datei $XDG_CONFIG_HOME/screenlayout/current-setting.sh existiert nicht"
    fi
elif [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    echo -e "${ROT}WAYLAND: xrandr nicht möglich"
else
    echo -e "${ROT}Fehler: Unbekannter Session-Typ"
fi

