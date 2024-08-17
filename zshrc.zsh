#!/usr/bin/env zsh
########################################################
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣  -NAME:	    zshrc.zsh
## ╚  ╩╩═╝╚═╝           ''''''''''''''''
##	 -PATH:    	/share/zsh/
##	 -STATUS:	work in progress
##	 -USAGE:	RC-File for zsh
## -------------------------------------
# FILE DATES	[yyyy-mmm-dd]ŝ
##..SAVE:	  	2024-...
##..CREATION:   2023
## -----------------------------------------
## AUTHOR:		mxx
## COMMENTS:	nixOS-version
#				mit ln -s . ./.zshrc
#####################################################

# Initialisiere Autocompletion
autoload -U compinit && compinit
# Füge den Pfad für Custom- u Autoload-Funktionen hinzu. When we run a command that corresponds to an autoloaded function, ZSH searches for it in the “fpath” and loads it into the memory if located.
fpath=($ZDOTDIR:$ZDOTDIR/functions:$ZDOTDIR/plugins $fpath)
# History-Einstellungen
export HISTIGNORE="ls:cd:pwd:exit:tldr:cheat"
setopt EXTENDED_HISTORY    # Zeitstempel speichern
setopt SHARE_HISTORY       # History sofort speichern
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
# unsetopt HIST_SAVE_NO_DUPS    # Write a duplicate event to the history file
setopt INC_APPEND_HISTORY 	# append the command without for shell exit

unsetopt MULTIBYTE
### ------------------------------ ##
# **ZSH DIRECTORY STACK** aka DS
### ------------------------------ ##
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
DIRSTACKSIZE=14
## wichtige Aliase für ZSH DIRECTORY STACK - DS
alias -g d='dirs -v'
for index ({1..14}) alias "$index"="cd -${index}"; unset index
setopt AUTO_CD   	# '..' statt 'cd ..'
REPORTTIME=3 		# display cpu usage, if command taking more than 3s

### ------------------------------ ##
## **ZSH GLOBBING**
### ------------------------------ ##
setopt EXTENDEDGLOB	# for superglob for ls **/*.txt oder ls -d *(D)
unsetopt CASEGLOB
setopt ALIAS_FUNC_DEF 	# if set, aliases can be used for defining functions
setopt INTERACTIVE_COMMENTS 	# allow comments even in interactive shells
setopt PRINT_EXIT_VALUE		# print the exit value of programs with non-zero exit status
setopt RM_STAR_WAIT		# wait 10s and ignore anything typed, avoid problem
				# of reflexively answering ‘yes’ to the query: rm *
setopt sh_word_split	# split multi-word variables into individual elements
			# try (n)with, and "unsetopt sh_word_split":
			# for word in $kitchen_items; do print "$word"; end
setopt notify		    # notifier fir big jobs
unsetopt beep		# beep ausschalten


 # autoload command load a file containing shell commands
 # autoload looks in directories of the "_Zsh file search path_", defined in the 
 # variable `$fpath`, and search a file called `compinit`.
  autoload -Uz compinit; compinit
  _comp_options+=(globdots) 	# With hidden files

## -----------------------------------------
#		Z S H Env definition
## -----------------------------------------
# Farb- und Textformatierungsvariablen
export INVERT="\e[7m"
export BOLD="\033[1m"
export UNDER="\033[4m"
export BLINK="\033[5m"
export RESET="\e[0m"
export PINK="\033[38;2;219;41;200m\033[48;2;59;0;69m"
export LILA="\033[38;2;85;85;255m\033[48;2;21;16;46m"
export GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
export GRUEN=$GREEN
export RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
export ROT=$RED
export GELB="\033[38;2;232;197;54m\033[48;2;128;87;0m"
export YELLOW=$GELB
export ROSA="\x1b[1m\x1b[38;5;162m\x1b[48;5;62m"

export CLICOLOR_FORCE=1
export TERM="rxvt-256color"
#  export SPACESHIP_CONFIG="$ZDOTDIR/prompt/spaceship.zsh" # Spaceship Prompt
# eval "$(starship init zsh)"
# eval "$(starship completions zsh)"

# eza-Einstellungen
export COLUMNS=78
export EZA_ICONS_AUTO="always"
export EZA_ICON_SPACING=2
export EZA_GRID_ROWS=3
export EZA_GRID_COLUMNS=3
export EZA_MIN_LUMINANCE=10
export EZA_COLORS=$LS_COLORS

# Projektpfade
export PRO="/home/project"
export NIX="/share/nixos/configurationNix"

#-------------------------------- __-----------
#	                             /  |
#	  ______   __     __ ______  $$ |
#	 /      \ /  \   /  /      \ $$ |
#	/$$$$$$  |$$  \ /$$/$$$$$$  |$$ |
#	$$    $$ | $$  /$$/ /    $$ |$$ |
#	$$$$$$$$/   $$ $$/ /$$$$$$$ |$$ |
#	$$      |/   $$$/  $$    $$ |$$ |
#	 $$$$$$$/     $/    $$$$$$$/ $$/

  eval "$(navi widget zsh)"   # mit "^g" fürs widget
# eval "$(hugo completion zsh)"
#_____________________________________________



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

# MANPAGER-Einstellungen
if command -v bat &> /dev/null; then
    export MANPAGER="bat --paging=always --style=changes -l man -p"
    echo "${PINK} \t... bat als man-pager ... check ${RESET}\t"
else
    export MANPAGER="less -FRX"
    echo "less -FRX als man-pager  ... check ${RESET}"
fi
# 	 -----------------------------------------
#		  __ _  (_)__________ 
#		 /  ' \/ / __/ __/ _ \
#	 	/_/_/_/_/\__/_/  \___/
#	 -----------------------------------------
# Prüfen, ob 'micro' installiert ist
if command -v micro &> /dev/null; then
    export MICRO_CONFIG_HOME="/share/micro"
    echo "\t${GREEN} micro  ... check ${RESET}\t"
else
    echo "\t${RED} micro ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}\n"
fi
# -----------------------------------------
#		__ __    .___ ___
#		 //  \\_/||  \|__
#		/_\__// \||__/|___
# 	 -----------------------------------------
# Prüfen, ob 'zoxide' installiert ist
if command -v zoxide &> /dev/null; then
    export _ZO_ECHO=1  # 1... will print the matched directory before navigating to it
    export _ZO_DATA_DIR="$ZDOTDIR/zoxide"
    eval "$(zoxide init zsh)"
    alias za='zoxide add'
 	alias zq='zoxide query'
 	alias zqi='zoxide query -i'
 	alias zr='zoxide remove'
    echo "\t${PINK} zoxide ... check ${RESET}\t"
	sleep 0.1

else
    echo "\t${RED} zoxide ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
	sleep 0.5

fi
#	----------__------------_----------------
#		 ____/ /  ___ ___ _/ /_
#		/ __/ _ \/ -_) _ `/ __/
#		\__/_//_/\__/\_,_/\__/
#	------------------------------------------
# Prüfen, ob 'cheat' installiert ist
if command -v cheat &> /dev/null; then
    export CHEAT_USE_FZF="true"
    export CHEAT_CONFIG_PATH="$ZDOTDIR/cheat/conf4cheat.yml"
    echo "\t${GREEN} cheat  ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} cheat ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
	sleep 0.1
fi
### ------------------------------------------------------- ###
#		╔═╗╔═╗╦ ╦    ╦ ╦╦╔═╗╦ ╦╦  ╦╔═╗╦ ╦╔╦╗╦╔╗╔╔═╗
#		╔═╝╚═╗╠═╣    ╠═╣║║ ╦╠═╣║  ║║ ╦╠═╣ ║ ║║║║║ ╦
#		╚═╝╚═╝╩ ╩────╩ ╩╩╚═╝╩ ╩╩═╝╩╚═╝╩ ╩ ╩ ╩╝╚╝╚═╝
# [
# "main" "brackets" "pattern" "cursor" "regexp" "root" "line"
# ]
# source_or_error "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES=(
#     bracket-error="fg=red,bold"
#     bracket-level-1="fg=blue,bold"
#     bracket-level-2="fg=cyan,bold"
#     bracket-level-3="fg=yellow,bold"
#     bracket-level-4="fg=magenta,bold"
#     line="bold"
#     cursor="bg=blue"
#     alias="fg=magenta,bold"
#     path="fg=cyan"
#     globbing="none"
#     root="bg=red"
# )
#  		#avoid partial path lookups on a path
#  		# ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(/mnt/slow_share)
#  	typeset -A ZSH_HIGHLIGHT_REGEXP
#  		ZSH_HIGHLIGHT_REGEXP+=('^rm .*' fg=red,bold)
#  		ZSH_HIGHLIGHT_REGEXP+=('\<sudo\>' fg=123,bold)
#  		ZSH_HIGHLIGHT_REGEXP+=('[[:<:]]sudo[[:>:]]' fg=123,bold)
### ------------------------------------------------------- ###
#   ███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗
#   ██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝
#   ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗
#   ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝
#   ███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗
#   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝
### ------------------------------------------------------- ###
# Funktion zum Sourcen von Dateien oder Ausgabe einer Fehlermeldung
source_or_error() {
    if [ -f "$1" ]; then
        source "$1"
        printf "\t${GREEN}source pass:\t${RESET}${GELB}${BOLD}$1 ${RESET}\n"
    else
        printf "\t${RED}${BLINK} nicht gefunden!${RESET}${GELB}${BOLD} $1\t${RED}${BLINK} nicht gefunden! ${RESET}\n"
    fi
}
# Sourcen von Konfigurationsdateien
echo "--------------------------------------------------------" | blahaj -i -r
	sleep 0.1
	source_or_error "$ZDOTDIR/functions/my-functions.zsh"
	sleep 0.1
	source_or_error "$ZDOTDIR/prompt/cyber.zsh"
	sleep 0.1
	source_or_error "$ZDOTDIR/plugins/fff-fuck.zsh"
	sleep 0.1
	source_or_error "$ZDOTDIR/plugins/fzf-key-bind.zsh"
	sleep 0.1
	source_or_error "$ZDOTDIR/plugins/shortcuts.zsh"
	sleep 0.1
	source_or_error "$ZDOTDIR/functions/zfunctions.zsh"
	sleep 0.1
	source_or_error "$ZDOTDIR/functions/zfunctions2.zsh"  # todo: buggy
	sleep 0.1
	source_or_error "$ZDOTDIR/aliases.zsh"
	source "$ZDOTDIR/plugins/zgreeting.zsh"
echo "--------------------------------------------------------" | blahaj -i -r

# autoload -Uz run-help

# Aktualisiere die Shell-Hash-Tabelle
# ...  häufig Programme installierst oder aktualisierst,
#  sicherstellt, dass deine Shell immer auf dem neuesten Stand ist
hash -r
### ------------------------------------------------------- ###

