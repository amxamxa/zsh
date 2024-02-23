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
## ------------------------------------
## AUTHOR:		mxx
## COMMENTS: 
###########################################
	
​￼
# laden der Screenn-Anordnung über XRANDR mit current-setting.sh
# bekomme den Standardpfad nicht unter $XDG_CONFIG_HOME
if [[ -e "$XDG_CONFIG_HOME/screenlayout/current-setting.sh" ]]; then
   # emulate zsh -c "$XDG_CONFIG_HOME/screenlayout/current-setting.sh" && \
    zsh "$XDG_CONFIG_HOME/screenlayout/current-setting.sh" && \
    cowsay "xrandr über korrekt über $XDG_CONFIG_HOME/screenlayout config ausgeführt" | clolcat && \
    xcowsay --image="$HOME/Bilder/nixOS-logo.png" --time=3 --at=1200,200 --monitor=0 --left --font=unifont "xrandr über korrekt über $XDG_CONFIG_HOME/screenlayout config ausgeführt"
 else    
  cowsay "xrandr NICHT !!! über korrekt über $XDG_CONFIG_HOME/screenlayout config ausgeführt" | clolcat
fi
# test
# if [[ -e "$HOME/.screenlayout/current-setting.sh"]]; then
	# emulate sh -c "$HOME/.screenlayout/current-setting.sh" && /
	# echo -e "${lila} xrandr über config falsch  $HOME/.screenlayout/current-setting.sh ausgeführt!";
# fi
