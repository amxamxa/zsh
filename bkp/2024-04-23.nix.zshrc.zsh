#!/usr/bin/env zsh
##########################################
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣  -NAME:	    .zshrc
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

# Get the number of lines in .theme_history
num_themes=$(wc -l < $XDG_CONFIG_HOME/.theme_history)
# Generate a random number between 1 and the number of themes
random_num=$((1 + RANDOM % num_themes))
# Get the theme at the random line number
selected_theme=$(sed -n "${random_num}p" < $XDG_CONFIG_HOME/.theme_history)
# Apply the selected theme
echo -e "${PINK}${BLINK} Setting terminal theme to: $selected_theme${RESET}"
command theme.sh $selected_theme
#theme.sh mellow-purple #https://github.com/lemnos/theme.sh


###################################
# 	███╗   ███╗██╗  ██╗██╗  ██╗
# 	████╗ ████║╚██╗██╔╝╚██╗██╔╝
# 	██╔████╔██║ ╚███╔╝  ╚███╔╝
# 	██║╚██╔╝██║ ██╔██╗  ██╔██╗
# 	██║ ╚═╝ ██║██╔╝ ██╗██╔╝ ██╗
#  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
############################### #### ansi shadow                        # 
# 	┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
# 	├┤ │ │││││   │ ││ ││││└─┐
#   └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘
###################################calvin

# Füge den Pfad für Custom-Funktionen hinzu
fpath=($ZDOTDIR $fpath)

# Fuck-Funktion (korrigierte Formatierung)
fuck () {
    local TF_PYTHONIOENCODING TF_SHELL TF_ALIAS TF_SHELL_ALIASES TF_HISTORY TF_CMD
    TF_PYTHONIOENCODING=$PYTHONIOENCODING
    export TF_SHELL=zsh
    export TF_ALIAS=fuck
    TF_SHELL_ALIASES=$(alias)
    export TF_SHELL_ALIASES
    TF_HISTORY="$(fc -ln -10)"
    export TF_HISTORY
    export PYTHONIOENCODING=utf-8
    TF_CMD=$(thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@) && eval $TF_CMD
    unset TF_HISTORY
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING
    test -n "$TF_CMD" && print -s $TF_CMD
}

### ------------------------------ ###
##   Globale Suffix-Aliases erweitern
### ------------------------------ ###
# -Aliases erweitern aka sehen kann, mit Leertaste
 globalias() {
			   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
			     zle _expand_alias
			     zle expand-word
			   fi
			   zle self-insert
 			}
	 zle -N globalias
	 bindkey " " globalias
 
 # control-space to bypass completion
 	bindkey "^ " magic-space   
 # normal space during searches       
 	bindkey -M isearch " " magic-space 

# sonstige Shortcuts in File shortcuts.zsh



### ------------------------------ ###
#        Funktion COPYto .... aliases.maybe  
# Speichert den letzten Befehl in die Datei #
# $ZDOTDIR/aliases.maybe und gibt eine Bestätigungsmeldung aus.
### ------------------------------ ###
 function COPYtoZ() {
	 # 'echo $(fc -ln -1)' gibt den letzten Befehl aus.
	 # 'tee -a $ZDOTDIR/aliases.maybe' fügt den Ausgabetext 
	 # an die Datei $ZDOTDIR/aliases.maybe an.
	  echo $(fc -ln -1) | tee -a $ZDOTDIR/aliases.maybe
	 # Überprüft, ob der letzte Befehl erfolgreich ausgeführt wurde.
	 if [ $? -eq 0 ]; then
		   # Wenn der Befehl erfolgreich ausgeführt wurde, gibt diese Funktion eine Bestätigungsmeldung aus.
		   echo "Befehl $(fc -ln -1) wurde erfolgreich an $ZDOTDIR/aliases.maybe angehängt."
	 else
		   # Wenn der Befehl fehlgeschlagen ist, gibt diese Funktion eine Fehlermeldung aus.
		   echo "Fehler beim Anhängen des Befehls $(fc -ln -1) an $ZDOTDIR/aliases.maybe."
	 fi
}
########################################################
#	 ________  ________   ________ 
#	|\  _____\|\_____  \ |\  _____\
#	\ \  \__/  \|___/  /|\ \  \__/ 
#	 \ \   __\     /  / / \ \   __\
#	  \ \  \_|    /  /_/__ \ \  \_|
#	   \ \__\    |\________\\ \__\ 
#	    \|__|     \|_______| \|__| 
                               
 function FZFedit()  {
	fzf --preview 'bat --color=always {}' --preview-window '~6' | xargs -o micro   	}	
							
function FZFman()  {
	# Beschreibung: Durchsucht die Man-Pages nach  
	# Suchbegriff mithilfe fzf um ausgewählte Man-Page anzuzeigen
	man -k . \
	| fzf -q "$1" --prompt='man> ' --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' \
	| tr -d '()' \
	| awk '{printf "%s ", $2} {print $1}' \
	| xargs -r man  }

function FZFsysctl()  {
	systemctl --no-legend --type=service --state=running | fzf | awk '{print $1}' | xargs sudo systemctl restart			}

function FZFkill()  {
 # Beschreibung: fuzzy pid killer
    local pid
    # Informationen über alle Prozesse des aktuellen Benutzers abzurufen.
    pid=$(ps aufxc --user $(id -u) \
        | sed 1d \
        | fzf -m \
        | awk '{print $2}')
        #mit if wird überprüft, ob pid nicht leer ist 
    if [[ -n "$pid" ]]; then
    # Wenn das erste Argument ($1) nicht gesetzt ist, verwende 'TERM'
     kill -${1:-TERM} $pid
    fi                   }
#	┌─┐┬ ┬┌─┐┬┌─   ┌─┐┬┬  ┌─┐  ┌┬┐┌─┐┬─┐
#	├┤ │ ││  ├┴┐───├┤ ││  ├┤───││││ ┬├┬┘
#	└  └─┘└─┘┴ ┴   └  ┴┴─┘└─┘  ┴ ┴└─┘┴└─
# Add this to your .zshrc or equivalent.
# Run 'FF' with 'fff' or whatever you decide to name the function.
FF() {
	    fff "$@"
	    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
	}
	# Show/Hide hidden files on open. 1=on
	export FFF_HIDDEN=1
	# Use LS_COLORS to color fff. 1= on
	export FFF_LS_COLORS=1
	export FFF_OPENER="xdg-open"
	# File Attributes Command
	export FFF_STAT_CMD="stat"
	export FFF_FILE_FORMAT="%f"
	export FFF_MARK_FORMAT=">  %f*"
	# w3m-img offsets.
	export FFF_W3M_XOFFSET=0
	export FFF_W3M_YOFFSET=0

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

# Hinzufügen des Pfads für zsh-syntax-highlighting und zsh-colored-man-pages
fpath=($ZDOTDIR $fpath)
# Hinzufügen des Pfads für nix-zsh-completions
fpath=($HOME/zsh/nix-zsh-completions $fpath)
# Initialisiere Autocompletion
autoload -U compinit && compinit

# Funktion zum Quellen einer Datei oder Ausgabe einer Fehlermeldung
source_or_echo_error() {
    if [ -f "$1" ]; then
        source "$1"
        echo -e "#\t${GREEN}source pass:\t${RESET}${GELB}${BOLD}$1${RESET}"
    else
        echo -e "\t${RED}${BLINK} nicht gefunden!${RESET}${GELB}${BOLD} $1\t${RED}${BLINK} nicht gefunden!${RESET}\n"
    fi
 }

# Source plugins
	source_or_echo_error "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
	source_or_echo_error "$ZDOTDIR/nix-zsh-completions/nix-zsh-completions.plugin.zsh"
	source_or_echo_error "$ZDOTDIR/zsh-colored-man-pages/colored-man-pages.plugin.zsh"
# Source aliases and functions 	
	source_or_echo_error "$ZDOTDIR/aliases.zsh"
	source_or_echo_error "$ZDOTDIR/shortcuts.zsh"
	source_or_echo_error "$ZDOTDIR/zfunctions.zsh"
		#	Hstat -Display the command more often used in the shell
		#	backup - a file w/EXT: bkp
		#	cheat - tldr
		#	Zcomp - Display all autocompleted command in zsh
		#	Ports  - offene lan ports
		#	GENplaylist - 
		#	PRspeed - Zeigt die Zeit an, zur Prompt beim Öffnen
		#             einer neuen zsh-Instanz angezeigt wird
	source_or_echo_error "$ZDOTDIR/zfunctions2.zsh"  # todo: buggy
#-	source_or_echo_error "$ZDOTDIR/testbed.zsh"      # todo: buggy

 
###################################################
#	__ __      __  ___ 
#	 //  \\_/||  \|__  
#	/_\__// \||__/|___ 
############## zoxide
#  "eval "$(zoxide init zsh)"" in der .zshrc-Datei 
# fü entsprechenden Funktionen und Aliase für die zoxide 
eval "$(zoxide init zsh)"

#################################################
#		╔═╗╦═╗╔═╗╔╦╗╔═╗╔╦╗
#zsh -	╠═╝╠╦╝║ ║║║║╠═╝ ║ 
#		╩  ╩╚═╚═╝╩ ╩╩   ╩ 
#################################################
# Benutzerdefinierter Prompt mit Git-Branch und Exit-Status
# function prompt_info() {
#     local exit_status="%(?..%F{red}%?%f)"
#     local git_branch="%{$fg[cyan]%}%F{240}%f%B%1v%b%f"
# 
#     PS1="$exit_status$git_branch> "
# }
# 
# PROMPT=prompt_info
# autoload -Uz promptinit
#  promptinit
#  prompt bigfade

#!!!! " prompt off "  before setting your prompt. 
# otherwise will interact wired w/config

prompt off 
 
 ###  powerlevel10k
 ### ------------------ ###
 # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
 #% p10k configure # to config
 if [[ -r $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme ]]; 
  then 
 	source "$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme"
	POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
 fi
 
 # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/ZSH/.zshrc.
 # Initialization code that may require console input (password prompts, [y/n]
 # confirmations, etc.) must go above this block; everything else may go below.
 if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
 fi
 # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
	#alt:    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
	[[ ! -f $ZDOTDIR/prompt-p10.zsh ]] || source $ZDOTDIR/prompt-p10.zsh

	POWERLEVEL9K_MODE="lalezar-fonts"
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
	POWERLEVEL9K_CONTEXT_TEMPLATE=$'\ue795'
	POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='#0abdc6'
	POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='#321959'
	POWERLEVEL9K_DIR_HOME_FOREGROUND='#0abdc6'
	POWERLEVEL9K_DIR_HOME_BACKGROUND='#0b2956'
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='#0abdc6'
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='#0b2956'
	POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='#0abdc6'
	POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='#0b2956'
	POWERLEVEL9K_DIR_ETC_FOREGROUND='#0abdc6'
	POWERLEVEL9K_DIR_ETC_BACKGROUND='#0b2956'
	POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#ea00d9'
	POWERLEVEL9K_VCS_CLEAN_BACKGROUND='#321959'
	POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#f57800'
	POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='#321959'
	POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#00ff00'
	POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='#321959'
	POWERLEVEL9K_STATUS_OK_BACKGROUND='#321959'
	POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#ff0000'
	POWERLEVEL9K_STATUS_ERROR_BACKGROUND='#321959'
	POWERLEVEL9K_HISTORY_BACKGROUND='#0b2956'
	POWERLEVEL9K_HISTORY_FOREGROUND='#0abdc6'
	POWERLEVEL9K_TIME_BACKGROUND='#321959'
	POWERLEVEL9K_TIME_FOREGROUND='#ea00d9'
	POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
########################################################################

# Aktualisiere die Shell-Hash-Tabelle
# ...  häufig Programme installierst oder aktualisierst, 
#  sicherstellt, dass deine Shell immer auf dem neuesten Stand ist
hash -r


#################  #################################  ################

# konfig  Fzf-Zsh-Tab-Plugin #################  ########

# #? ZSH_AUTOSUGGEST_STRATEGY=()
# 
 # if [ -f "/run/current-system/sw/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" ]; then
     # source "/run/current-system/sw/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"
 # fi
# 
	# # basic file preview for ls (you can replace with something more sophisticated than head)
	# zstyle ':completion::*:lsd::*' fzf-completion-opts --preview='eval head {1}'
# 
	# # preview when completing env vars (note: only works for exported variables)
	# # eval twice, first to unescape the string, second to expand the $variable
	# zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval eval echo {1}'
# 
	# # preview a `git status` when completing git add
	# zstyle ':completion::*:git::git,add,*' fzf-completion-opts --preview='git -c color.status=always status --short'
# 
	# # if other subcommand to git is given, show a git diff or git log
	# zstyle ':completion::*:git::*,[a-z]*' fzf-completion-opts --preview='
	# eval set -- {+1}
	# for arg in "$@"; do
	    # { git diff --color=always -- "$arg" | git log --color=always "$arg" } 2>/dev/null
	# done'
# 
	# # Aktiviert die Fzf-basierte Tab-Vervollständigung beim Drücken der Tab-Taste
# #?	bindkey '^I' fzf-tab-complete-or-accept
	
	# # Navigiere durch die Ergebnisse der Fzf-Vervollst ändigung mit den Pfeiltasten
	# bindkey '^P' fzf-tab-up
	# bindkey '^N' fzf-tab-down
	# # Anzahl der angezeigten Ergebnisse auf 30 begrenzen
	# export FZF_COMPLETION_TRIGGER_MAX=30
	# # Mehrfachauswahl erlauben
	# export FZF_COMPLETION_MULTI=1



