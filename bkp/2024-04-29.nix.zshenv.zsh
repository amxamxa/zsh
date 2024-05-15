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
	

### --------------- ##
##   COLORS         ##  Farb- und Formatierungsvariablen
## ---------------- ##
# LILA HEX: 39257D PINK=#db29c8 LILA-DARK=#100438 LILA-med=#3B0045 
# GELB HEX: #E8C536 #FFCA5B #805700 #edd400 #8ae234
	INVERT="\e[7m" 	 # invert 	 txt color
	RESET="\e[0m" 	 # reset  	 txt color
	BOLD="\033[1m"	 # bold 	 txt color
	UNDER="\033[4m"  # underline txt color
	BLINK="\033[5m"  # blink	 txt color
###	SYNTAX:
##	FARBE= "\033[38;2;"*R*;*G*;*B*"m\033[48;2;"*R*;*G*;*B*m"" # FARBE(fg) auf farbe (bg)
# Z-B=echo -e  "\033[38;2; INTEGERm  \033[48;2;#IN;TE;GERm m  txt hallo Welt!"
	PINK="\033[38;2;219;41;200m\033[48;2;59;0;69m" #PINK auf dunkel
	GELB="\033[38;2;232;197;54m\033[48;2;128;87;0m" #gelb auf dunkel
	LILA="\033[38;2;85;85;255m\033[48;2;21;16;46m" # LILA auf dunkel
	GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m" 
	RED="\033[38;2;240;138;100m\033[48;2;147;18;61m" #Rot auf Rot



export TERM=xterm-256color #powerline-go uses ANSI color codes

#rxvt-256color-Steuerung mit zusätzlichen Funktionen 
#...  erweiterte Version der xterm-256color  bietet
#TERM=rxvt-256color
#Farbausgabe aktivieren, unabhängig von den Terminal-Einstellungen
export CLICOLOR_FORCE=1 #Farbausgabe deaktivieren = 0

	
#setzt nemo =standard file mgmt
#in configuration.nix
	#xfconf-query -c xfce4-session -p /desktop/DefaultApps/FileManager -n -c -t string -s Default
	#xfconf-query -c xfce4-session -p /desktop/DefaultApps/FileManager/Default -n -t string -s nemo
	#xdg-mime default nemo.desktop inode/directory
	#xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-searches


export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

#flatpak by mxx, 2024-01
export PATH="$PATH:$HOME/.config/.local/share/flatpak/exports/share"
# Created by `pipx` on 2023-12-11 14:52:13
export PATH="$PATH:$HOME/.local/bin"

#github
export GIT_CONFIG="$XDG_CONFIG_HOME/git/.gitconfig"
# kitty, nur PATH angeben:
export KITTY_CONFIG_DIRECTORY="$XDG_CONFIG_HOME/kitty"

# Set Micro as default editor
export VISUAL=micro
export EDITOR="$VISUAL"


export PAGER="less --use-color --clear-screen"

## ---------------- ##
##   f z f config   ##
## ---------------- ##
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="--height 60% \
	--border sharp \
	--layout reverse \
	--color '$FZF_COLORS' \
	--prompt '∷ ' \
	--pointer ▶ \
	--marker ⇒"

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"
export FZF_COMPLETION_DIR_COMMANDS="
	cd 	z 	pushd  
	rmdir tree 	lsd eza
	 "

FZF_COLORS="
	g+:-1,\
	fg:#805700,\
	fg+:white,\
	border:#09F573,\
	spinner:#3B0045,\
	hl:yellow,\
	header:blue,\
	info:green,\
	pointer:red,\
	marker:blue,\
	prompt:#A9F9AD,\
	hl+:red"

# eza - environment variables
#eza --almost-all --group-directories-first --total-size --no-permissions --color-scale size 
export EZA_ICONS_AUTO="always"
export EZA_ICON_SPACING=2
export EZA_GRID_ROWS=3
export EZA_GRID_COLUMNS=3
export EZA_COLORS=$LS_COLORS



##---------
# Kosmetik
## ---------
# dir exist?
if [ -d ~/Schreibtisch ]; then
  rm -vr ~/Schreibtisch &> /dev/null
fi
#.sudo_as_admin_successful
if [ -e ~/.sudo_as_admin_successful ]; then
  rm ~/.sudo_as_admin_successful &> /dev/null
fi
# ~/.wget-hst
if [ -e ~/.wget-hsts ]; then
  rm  ~/.wget-hsts &> /dev/null
fi
#.xsession-errors/
if [ -e ~/.xsession-errors ]; then
  rm ~/.xsession-errors &> /dev/null
fi
#sudo nemo --fix-cache

# Only execute this file once per shell.
  #if [ -n "$__ETC_ZSHRC_SOURCED" -o -n "$NOSYSZSHRC" ]; then return; fi
 # __ETC_ZSHRC_SOURCED=1
#---------------



  
# #xrandr
# if [ "$__ETC_ZSHENV_SOURCED" != "1" ]; then
#     echo "The value of \$__ETC_ZSHENV_SOURCED is not equal to 1."
#     if [ -e "$ZDOTDIR/xscreenlayout.zsh" ]; then
# 	        zsh -c "$ZDOTDIR/xscreenlayout.zsh"
# 	        echo -e "${GREEN}$xscreenlayout.zsh ausgeführt${RESET}"
# 	    else
# 	        echo -e "${RED}$xscreenlayout.zsh fehlt oder so${RESET}"
# 	fi
#     # Setze die Variable, um anzuzeigen, dass die Datei geladen wurde
#     #    export __ETC_ZSHENV_SOURCED=1     
# fi


# source $ZDOTDIR/.zshrc # erfolgt automatisch

