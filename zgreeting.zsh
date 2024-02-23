#!/usr/bin/env zsh

##########################################
## ╔═╗╦╦  ╔═╗ ############################
## ╠╣ ║║  ║╣ 
## ╚  ╩╩═╝╚═╝
##	 -PATH:    	/home/zsh/
##	 -NAME:	  	greeting-nix.zsh
##	 -STATUS:	work in progress
##	 -USAGE:	RC-File for zsh 
## -------------------------------------
## FILE DATES	[yyyy-mmm-dd]
## .. SAVE:	  	2024-feb-23
## .. CREATION: july 2023
## -----------------------------------------
## AUTHOR:		mxx
## COMMENTS: 	angepasst an nixOS,
##				Vorlage aus meim deb-repository
###########################################
	
# Kopfzeile für das Terminal mit 'toilet' und 'lolcat' gestalten
toilet -F gay -f smscript "³³³³³³³³³³³³³³³³³³³³" | sed -e 's/^/\t/' | clolcat --seed=250   

## Dateikörper

## COW FUNCTION
# Funktion zum Anzeigen eines zufällig ausgewählten 'cowfiles'
# cowfiles einlesen
LIST=$(cowsay -l | grep -oE "[a-zA-Z0-9_-]+" | awk 'NR>=11')   
# zufälliges cowfile auswählen
RANDOM_COW=$(echo "$LIST" | shuf -n 1)   
# Anzeige des ausgewählten cowfiles
echo -e "\t${UNDER}${LILA}Selected Random ${BOLD} Cow File:${RESET}\t" | sed -e 's/^/\t\t/'

# Abfrage x11 or not
if [[ "$x11_set" == "true" ]]; 
   then
    #entspricht 1x Screens
   xrandr --output VGA-1-1 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-1-1 --off \
   		--output DP-1-1 --off --output HDMI-2 --off --output VGA-2 --off \
		--output DVI-I-1 --primary --mode 1920x1080 --pos 1080x728 --rotate normal 
  else
     hyfetch -v --config-file $XDG_CONFIG_HOME/hyfetch.json
fi

# ... falls x11 wahr ist ...
if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
	 # X11 wird verwendet
	 export x11_set="true"
  else
	# x11 wird NICHT verwendet
	 printf "${GELB}x11 wird ${PINK} \n* NICHT* ${RESET} \n ${GELB}verwendet ${RESET}\n" | cowsay -n -fbong
	  #echo "x11 wird nicht verwendet"|clolcat|cowsay
fi


    echo -e "\t${BOLD}\t${BLINK}\t$RANDOM_COW" | clolcat --seed=123 --spread=0.1 --force --truecolor --animate --duration=12 | sed -e 's/^/\t/'
    # Meldung anzeigen, dass X11 verwendet wird
    printf "${BOLD}${GREEN}\tX11 wird verwendet,\t\t  ${RESET} \n${UNDER}${GREEN} xrandr für x11 sowie und 2 Bildschirme    ${RESET}\n${GREEN} ${BOLD}\twurde erfolgreich ausgeführt        ${RESET}" | cowsay -n -W 40 -f "${RANDOM_COW}" | sed -e 's/^/\t\t/'
else
    echo "x11 NOK"
fi 

echo


# Toilet-Animation am Ende
toilet -F gay -f smscript "³³³³³³³³³³³³³³³³³³³³" | sed -e 's/^/\t/' | clolcat --seed=255   
echo
