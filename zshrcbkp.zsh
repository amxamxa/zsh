/usr/bin/env zsh
##########################################
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣  -NAME:	    zshrc.zsh    
## ╚  ╩╩═╝╚═╝           ''''''''''''''''
##	 -PATH:    	/share/zsh/
##	 -STATUS:	work in progress
##	 -USAGE:	RC-File for zsh 
## -------------------------------------
# FILE DATES	[yyyy-mmm-dd]
##..SAVE:	  	2024-...
##..CREATION:   2023
## -----------------------------------------
## AUTHOR:		mxx
## COMMENTS: 	
###########################################

## -----------------------------------------
#		Z S H 	PROMPT
## -----------------------------------------
# anderweitig in zsh.nix definiert:
# p10k-fancy.zsh ... ist das config-file:  
# [[ ! -f "$ZDOTDIR/prompt/p10k-fancy.zsh" ]] || source "$ZDOTDIR/prompt/p10k-fancy.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
#if [[ -r "$ZDOTDIR/prompt/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "$ZDOTDIR/prompt/p10k-instant-prompt-${(%):-%n}.zsh"
#fi
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# ALTERNATIV zu POWERLEVEL9/10k- prompt:
# source /share/zsh/prompt/basic-prompt.zsh
## -----------------------------------------
#		Z S H Env definition
## -----------------------------------------

	export INVERT="\e[7m"          
	export BOLD="\033[1m"          
	export UNDER="\033[4m"         
	export BLINK="\033[5m"          
	export RESET="\e[0m"       
	export PINK="\033[38;2;219;41;200m\033[48;2;59;0;69m"       
	export LILA="\033[38;2;85;85;255m\033[48;2;21;16;46m"
	export GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"      
	export RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
	export GELB="\033[38;2;232;197;54m\033[48;2;128;87;0m"
	export ROSA="\x1b[1m\x1b[38;5;162m\x1b[48;5;62m"

  	export CLICOLOR_FORCE=1;
  	export TERM="rxvt-256color";
  	 	
#  export SPACESHIP_CONFIG="$ZDOTDIR/prompt/spaceship.zsh" # Spaceship Prompt
    export PRO="/home/project"
    export NIX="/share/nixos/configurationNix"
    
export HISTIGNORE="ls:cd:pwd:exit:tldr:cheat"
setopt EXTENDED_HISTORY      # Zeitstempel speichern
setopt SHARE_HISTORY         # History sofort speichern
setopt INC_APPEND_HISTORY    # History sofort speichern



if command -v micro &> /dev/null; then
	export MICRO_CONFIG_HOME="/share/micro"
	 echo "\t${GREEN} micro ... check ${RESET}\t"
	 fi
else
    echo "\t${RED} micro ist nicht installiert.  Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}\n"
fi
#	--------------------------------
#		__ __    .___ ___
#		 //  \\_/||  \|__  
#		/_\__// \||__/|___ 
#	--------------------------------
if command -v zoxide &> /dev/null; then
    export _ZO_ECHO=1  # 1... will print the matched directory before navigating to it
    export _ZO_DATA_DIR="$ZDOTDIR/zoxide" 
    # src Funktionen und Aliase für die zoxide 
    eval "$(zoxide init zsh)"
    echo "\t${PINK} zoxide ... check ${RESET}\t"
else
    echo "\t${RED}zoxide ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
fi
#	----------------------------------

#	------__------------_--------------
#	 ____/ /  ___ ___ _/ /_
#	/ __/ _ \/ -_) _ `/ __/
#	\__/_//_/\__/\_,_/\__/ 
#	--------------------------------
                       
if command -v cheat &> /dev/null; then
	export CHEAT_USE_FZF="true"
  	export CHEAT_CONFIG_PATH="$ZDOTDIR/cheat/conf4cheat.yml"
  	echo "\t${GREEN} cheat ... check ${RESET}\t"
 else
    echo "${RED}/tcheat ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
fi
#	----------------------------------

# man eza - environment variables
#eza --almost-all --group-directories-first --total-size --no-permissions --color-scale size 
export COLUMNS=76
export EZA_ICONS_AUTO="always"
export EZA_ICON_SPACING=2
export EZA_GRID_ROWS=3
export EZA_GRID_COLUMNS=3
export EZA_MIN_LUMINANCE=10 
export EZA_COLORS=$LS_COLORS


# MANPAGER-Einstellungen
if command -v bat &> /dev/null; then
	export MANPAGER="bat --paging=always --style=changes -l man -p"
	echo "${ROSA}${BLINK}... bat als man-pager ... check ${RESET}\t"

else
	export MANPAGER="less -FRX"
	echo "less -FRX als man-pager ... check ${RESET}"
fi

# Initialisiere Autocompletion
autoload -U compinit && compinit
# Füge den Pfad für Custom- u Autoload-Funktionen hinzu. When we run a command that corresponds to an autoloaded function, ZSH searches for it in the “fpath” and loads it into the memory if located.
fpath=($ZDOTDIR:$ZDOTDIR/functions:$ZDOTDIR/plugins $fpath)

### ------------------------------ ###
#    * *  S O U R C E plugins   * * ##
### ------------------------------ ###

# ███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗     
# ██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝     
# ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗       
# ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝       
# ███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗     
# ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝     

# ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
# ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
# ██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗
# ██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
# ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
# ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝            

# Source plugins
# ----------------------------------------------------------------
# Funktion zum Sourcen von Dateien oder Ausgabe einer Fehlermeldung
source_or_error() {
    if [ -f "$1" ]; then
      source "$1"
        printf "#\t${GREEN}source pass:\t${RESET}${GELB}${BOLD}$1${RESET}\n"
    else
        printf "\t${RED}${BLINK} nicht gefunden!${RESET}${GELB}${BOLD} $1\t${RED}${BLINK} nicht gefunden!${RESET}\n"
    fi
 }
 # ----------------------------------------------------------------
 
#prompt p10k
#	source_or_error " $ZDOTDIR/prompt/p10k-fancy.zsh"
#		echo
#cyberpunk powerline		
	source_or_error "$ZDOTDIR/functions/my-functions.zsh"
#	term-col-theme
	echo
	source_or_error "$ZDOTDIR/prompt/cyber.zsh"
		echo
# fuckin fast file manger and thefuck
	source_or_error "$ZDOTDIR/plugins/fff-fuck.zsh"
		echo
	source_or_error "$ZDOTDIR/plugins/fzf-key-bind.zsh"
		echo
	source_or_error "$ZDOTDIR/plugins/shortcuts.zsh"
		echo
	source_or_error "$ZDOTDIR/functions/zfunctions.zsh"
			#	Hstat ,backup, Ports,...
		echo
	source_or_error "$ZDOTDIR/functions/zfunctions2.zsh"  # todo: buggy
		echo
	#	source_or_error "$ZDOTDIR/functions/testbed.zsh"      # todo: buggy
#		echo
	#	source_or_error "$ZDOTDIR/functions/was.zsh"
#			echo
	# Source aliases and functions 	
		source_or_error "$ZDOTDIR/aliases.zsh"
		echo
		source_or_error "$ZDOTDIR/plugins/zgreeting.zsh"

		
# [
# "main" "brackets" "pattern" "cursor" "regexp" "root" "line"
# ]
# source_or_error "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# 	typeset -A ZSH_HIGHLIGHT_STYLES
# 		# To define styles for nested brackets up to level 4
# 		[bracket-error]='fg=red,bold'
# 		[bracket-level-1]='fg=blue,bold'
# 		[bracket-level-2]='fg=cyan,bold'
# 		[bracket-level-3]='fg=yellow,bold'
# 		[bracket-level-4]='fg=magenta,bold'
# 		[line]='bold' 	
# 		[cursor]='bg=blue'
# 		# To differentiate aliases from other command types
# 		alias='fg=magenta,bold'
# 		# To have paths colored instead of underlined
# 		path='fg=cyan'
# 		# To disable highlighting of globbing expressions
# 		globbing='none'
# 		[root]='bg=red'
# 		  
# 		#avoid partial path lookups on a path
# 		# ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(/mnt/slow_share) 
# 	typeset -A ZSH_HIGHLIGHT_REGEXP
# 		ZSH_HIGHLIGHT_REGEXP+=('^rm .*' fg=red,bold)
# 		ZSH_HIGHLIGHT_REGEXP+=('\<sudo\>' fg=123,bold)
# 		ZSH_HIGHLIGHT_REGEXP+=('[[:<:]]sudo[[:>:]]' fg=123,bold)
# 		
#	source_or_error ${pkgs.nix-zsh-completions}/share/zsh/plugins/nix/init.zsh
	#source_or_error "$ZDOTDIR/.p10k.zsh"

#	source_or_error "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# eval "$(hugo completion zsh)"

 
 


########################################################################
#eval "$(starship init zsh)"
#eval "$(starship completions zsh)"

# autoload -Uz run-help

# Aktualisiere die Shell-Hash-Tabelle
# ...  häufig Programme installierst oder aktualisierst, 
#  sicherstellt, dass deine Shell immer auf dem neuesten Stand ist
hash -r


