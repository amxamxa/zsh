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
toilet -F gay -f ascii9 "xxooxoxooxx"
  
# Anzeige des ausgewählten cowfiles
echo -e "\t${UNDER}${LILA}Selected Random ${BOLD} Cow File:${RESET}\t${NIGHT}${BOLD}$RANDOM_COW" | sed -e 's/^/\t\t/'
 
# ... falls x11 wahr ist ...
if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
	 # X11 wird verwendet
	 export x11_set="true"
	
    # Meldung anzeigen, dass X11 verwendet wird
    printf "${BOLD}${GREEN}\tX11 wird verwendet,\t\t  ${RESET} \n${UNDER}${GREEN} xrandr für x11 sowie und 2 Bildschirme    ${RESET}\n${GREEN} ${BOLD}\twurde erfolgreich ausgeführt        ${RESET}" | cowsay -n -W 40 -f "${RANDOM_COW}"  | sed -e 's/^/\t/'
  else
	# x11 wird NICHT verwendet
	 printf "${GELB}x11 wird ${PINK} \n* NICHT* ${RESET} \n ${GELB}verwendet ${RESET}\n" | cowsay -n -fbong
	  #echo "x11 wird nicht verwendet"|clolcat|cowsay
fi
# toilet -F gay -f smmono9 "x-x-x-x-x-x-x-x-x-x" #  | clolcat -S 250   
toilet -F gay -f ascii9 "xxooxoxooxx"

echo "\t ${GELB}󱢇 \t ℜ ꬲ: ${RESET}  ░▒▓█ ${NIGHT}  ɾ ì օ է    ${MINT}█▓▒░${RESET}\t${CYAN}󱢇 ${RESET}\t"
echo "\t   ${PINK}󰯈 \t${MINT}░▒▓█  ${GREEN}Ⓐ  - Ⓒ  - Ⓐ  - Ⓑ  ${GOLD}  █▓▒░\t${RED}  󱢇 ${RESET}"
echo "\t     ${RED}󱢇 ${OLIVE} ıllıllı  ${LIME} Я  I  Ө  Ƭ ${SKY} ıllıllı\t${PINK}    󱢇 ${RESET}\t"
echo "\n  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u202  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021\n" | blahaj -w -b -c bi

# echo "\t${PINK} 󱢇 +    +  󰯈 		 ---	 Ⓐ Ⓒ Ⓐ Ⓑ 	 ---	 󰯈   +    + 󱢇 ${RESET}" 
#      
#        🙼🙼🙼 󰚍󰚍󰚍󰚍 🙽 🙽 🙽
#     󰚍󰚍󰚍󰚍󰚍󰚍󰚍 󱚡   🙽 🙽 🙽
#    🙼🙼 󱚡   	 🙽 󰚍  🙽 🙽🙽 
#   🙼🙼  󰧼  󱚡    	 🙽 🙽🙽 
#  🙼🙼   󱚡 	max kempter__🙽 🙽🙽
# 🙼🙼  🙼🙼󰚍󰚍󰚍  🙼🙼🙼🙼🙼🙼󰚍󰚍󰚍󰚍󰚍 🙽 🙽  🙽     
#   ___________________________________________ 󱢇   "
# ▓█  Ⓐ  - Ⓒ  - Ⓐ  - Ⓑ   █▓▒ \t  ${RESET}\t  ${RESET}"

# 󰯆 ⭕ 
# --- Ⓐ Ⓒ Ⓐ Ⓑ  ---
# ☭ 󱌣  󰌽     🪁 󰄛  󰟆 🐘 👮 
#    🐚   󰯆 ☠ 💀 󰯈 󰯆 󰨈 ☭ 󱢇 ☭ 󱌣  󰌽   
#   🪁 󰄛  󰟆 🐘 👮 Ⓐ Ⓒ Ⓐ Ⓑ ⭕ 
#    🐚   󰯆 ☠ 
# echo " 󰯈  󰯆 󰨈 ☭ 󱢇 ☭ 󱌣  󰌽     🪁 󰄛  󰟆 "


#echo "\n\u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u202  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021 \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021  \u01c2\u2021\u01c2\u2021\u01c2\u2021\u01c2\u2021\n" | blahaj -i -b -c bi

