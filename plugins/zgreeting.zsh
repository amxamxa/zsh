#!/usr/bin/env zsh
## ╔═╗╦╦  ╔═╗ ############################
## ╠╣ ║║  ║╣ 
## ╚  ╩╩═╝╚═╝
## -PATH:    	ZDOTDIR
## -NAME: 	zgreeting.zsh
## -STATUS:	work in progress
## -USAGE:	source zgreeting.zsh 
##		in RC-File for zsh 
## -------------------------------------
## FILE DATES	[yyyy-mmm-dd]
## .. CREATION: july 2023
## -----------------------------------------
## AUTHOR:		mxx
## COMMENTS: 	angepasst an nixOS,
##	Vorlage aus meim deb-repository
###########################################

## COW FUNCTION
# Funktion zum Anzeigen eines zufällig ausgewählten 'cowfiles'

# cowfiles einlesen
LIST=$(cowsay -l | grep -oE "[a-zA-Z0-9_-]+" | awk 'NR>=11')   
# zufälliges cowfile auswählen
RANDOM_COW=$(echo "$LIST" | shuf -n 1)   
# Anzeige des ausgewählten cowfiles
echo -e "\t${UNDER}${LILA}Selected Random ${BOLD} Cow File:${RESET}\t" | sed -e 's/^/\t\t/'

# ... falls x11 wahr ist ...
if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
	 # X11 wird verwendet
	 export x11_set="true"
	   echo -e "\t${BOLD}\t${BLINK}\t$RANDOM_COW" | sed -e 's/^/\t/'
    # Meldung anzeigen, dass X11 verwendet wird
    printf "${BOLD}${GREEN}\tX11 wird verwendet,\t\t  ${RESET} \n${UNDER}${GREEN} xrandr für x11 sowie und 2 Bildschirme    ${RESET}\n${GREEN} ${BOLD}\twurde erfolgreich ausgeführt        ${RESET}" | cowsay -n -W 40 -f "${RANDOM_COW}"  | sed -e 's/^/\t/'
  else
	# x11 wird NICHT verwendet
	 printf "${GELB}x11 wird ${PINK} \n* NICHT* ${RESET} \n ${GELB}verwendet ${RESET}\n" | cowsay -n -fbong
	  #echo "x11 wird nicht verwendet"|clolcat|cowsay
fi

echo "\t 󱢇 \t${SKY}  ℜ ꬲ:		░▒▓█   ɾ ì օ է  █▓▒░ ${RESET} \t 󱢇 "
echo
# echo "\t${PINK} 󱢇 +    +  󰯈 		 ---	 Ⓐ Ⓒ Ⓐ Ⓑ 	 ---	 󰯈   +    + 󱢇 ${RESET}" 
echo "\t\t${RED} 	  ıllıllı  Я I Ө Ƭ   ıllıllı "
#      
#        🙼🙼🙼 󰚍󰚍󰚍󰚍 🙽 🙽 🙽
#     󰚍󰚍󰚍󰚍󰚍󰚍󰚍 󱚡   🙽 🙽 🙽
#    🙼🙼 󱚡   	 🙽 󰚍  🙽 🙽🙽 
#   🙼🙼  󰧼  󱚡    	 🙽 🙽🙽 
#  🙼🙼   󱚡 	max kempter__🙽 🙽🙽
# 🙼🙼  🙼🙼󰚍󰚍󰚍  🙼🙼🙼🙼🙼🙼󰚍󰚍󰚍󰚍󰚍 🙽 🙽  🙽     
#   ___________________________________________ 󱢇   "

# 󰯆 ⭕ 
# --- Ⓐ Ⓒ Ⓐ Ⓑ  ---
# ☭ 󱌣  󰌽     🪁 󰄛  󰟆 🐘 👮 
#    🐚   󰯆 ☠ 💀 󰯈 󰯆 󰨈 ☭ 󱢇 ☭ 󱌣  󰌽   
#   🪁 󰄛  󰟆 🐘 👮 Ⓐ Ⓒ Ⓐ Ⓑ ⭕ 
#    🐚   󰯆 ☠ 
# 󰯈 󰯆 󰨈 ☭ 󱢇 ☭ 󱌣  󰌽     🪁 󰄛  󰟆 🐘 👮 Ⓐ Ⓒ Ⓐ Ⓑ ⭕ 
#toilet -F gay -f smmono9 "³--------------³" #  | clolcat -S 250   


