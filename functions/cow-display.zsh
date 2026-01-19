#!/usr/bin/env zsh
## ╔═╗╦╦  ╔═╗ ############################
## ╠╣ ║║  ║╣ 
## ╚  ╩╩═╝╚═╝
## -PATH:    	ZDOTDIR
## -NAME: 	zgreeting.zsh
## COMMENTS: 	angepasst an nixOS,
###########################################

# COW FUNCTION
# Function to display a randomly selected 'cowfile'
# Read available cowfiles starting from line 5 (skip header words)
LIST=$(cowsay -l | grep -oE "[a-zA-Z0-9_-]+" | awk 'NR>=5')
# zufälliges cowfile auswählen
RANDOM_COW=$(echo "$LIST" | shuf -n 1)   
# Anzeige des ausgewählten cowfiles
echo -e "\t${UNDER}${LILA}Selected Random ${BOLD} Cow File:${RESET}\t" | sed -e 's/^/\t\t/'
# Session-Type prüfen und entsprechend reagieren
case "$XDG_SESSION_TYPE" in
    x11)
        # X11 session detected
        export x11_set="true"
        echo -e "\t${BOLD}\t${BLINK}\t$RANDOM_COW" | sed -e 's/^/\t/'
        printf "${BOLD}${GREEN}\tX11 wird verwendet,\t\t  ${RESET} \n${UNDER}${GREEN} xrandr für x11 sowie und 2 Bilds\n" | cowsay -n -W 40 -f $RANDOM_COW
        ;;
    wayland)
        # Wayland session detected
        export wayland_set="true"
        echo -e "\t${BOLD}\t${BLINK}\t$RANDOM_COW" | sed -e 's/^/\t/'
        printf "${BOLD}${CYAN}\tWayland wird verwendet  ${RESET}\n"| cowsay -n -W 40 -f $RANDOM_COW
        ;;
    tty)
        # TTY console session (no display server)
        export tty_set="true"
        printf "${GELB}TTY-Konsole wird verwendet (kein Display-Server)${RESET}\n" | cowsay -n -fbong
        ;;
    unspecified|"")
        # Session type is unspecified or empty
        printf "${ORANGE}Session-Type nicht spezifiziert oder leer${RESET}\n" | cowsay -n -fbong
        ;;
    *)
        # Unknown or unsupported session type
        printf "${ROT}Unbekannter Session-Type: ${XDG_SESSION_TYPE}${RESET}\n" | cowsay -n -fbong
        ;;
esac

echo "\t 󱢇 \t${SKY}  ℜ ꬲ:		░▒▓█   ɾ ì օ է  █▓▒░ ${RESET} \t 󱢇 "
echo
# echo "\t${PINK} 󱢇 +    +  󰯈 		 ---	 Ⓐ Ⓒ Ⓐ Ⓑ 	 ---	 󰯈   +    + 󱢇 ${RESET}" 
echo "\t\t${PINK} 	  ıllıllı  Я I Ө Ƭ   ıllıllı "
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


