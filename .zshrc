## 2024 Februar
theme.sh elementary
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
 fpath=($ZDOTDIR $fpath)

fuck () {
        TF_PYTHONIOENCODING=$PYTHONIOENCODING;
        export TF_SHELL=zsh;
   		export TF_ALIAS=fuck;
  		TF_SHELL_ALIASES=$(alias);
   		export TF_SHELL_ALIASES;
    	TF_HISTORY="$(fc -ln -10)";
        export TF_HISTORY;
    	export PYTHONIOENCODING=utf-8;
     	TF_CMD=$(
         thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
   		 ) && eval $TF_CMD;
         unset TF_HISTORY;
         export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
         test -n "$TF_CMD" && print -s $TF_CMD
      }


### ------------------------------ ###
##      globale 
##       Suffix-Aliases erweitern
### ------------------------------ ###
# realisiert, dass man die globalen Suffix
# -Aliases erweitern aka sehen kann
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

    # ___          ___                     _
   # / __)        / __)     _             | |
 # _| |__ _____ _| |__    _| |_ ___   ___ | |  ___
# (_   __|___  |_   __)  (_   _) _ \ / _ \| | /___)
  # | |   / __/  | |       | || |_| | |_| | ||___ |
  # |_|  (_____) |_|        \__)___/ \___/ \_|___/
                                              # 

function FZFedit()  {
	fzf --preview 'bat --color=always {}' --preview-window '~6' | xargs -o micro   	}	
							
function FZFman()  {
	# Beschreibung: Durchsucht die Man-Pages nach  
	# Suchbegriff mithilfe von fzf und zeigt die ausgewählte Man-Page an.
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

#--------------------------------------------------------------------------------------------
# fff 
	# Add this to your .zshrc or equivalent.
	# Run 'fff' with 'f' or whatever you decide to name the function.
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
####### https://manytools.org/hacker-tools/ascii-banner/
fpath=($ZDOTDIR $fpath)

if [ -f "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
## zsh plugin for colorifies man pages and less 
if [ -f "$ZDOTDIR/zsh-colored-man-pages/colored-man-pages.plugin.zsh" ]; then
source "$ZDOTDIR/zsh-colored-man-pages/colored-man-pages.plugin.zsh" 
fi

# aliases file
source "$ZDOTDIR/aliases.zsh"
# config für die "completion" gesourct
if [ -f "$ZDOTDIR/nix-zsh-completions/nix-zsh-completions.plugin.zsh" ]; then 
source "$ZDOTDIR/nix-zsh-completions/nix-zsh-completions.plugin.zsh"
fi



fpath=($HOME/zsh/nix-zsh-completions $fpath)

autoload -U compinit && compinit

#################  #################################  ################

# konfig  Fzf-Zsh-Tab-Plugin #################  ################

# #? ZSH_AUTOSUGGEST_STRATEGY=()
# 
 # if [ -f "/run/current-system/sw/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" ]; then
     # source "/run/current-system/sw/share/zsh/pluginsfzf-tab/fzf-tab.plugin.zsh"
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

#prompt
# autoload -Uz promptinit
#  promptinit
#  prompt bigfade


#ANSI SHADOW#########################################
# ███████╗ ██████╗ ██╗  ██╗██╗██████╗ ███████╗
# ╚══███╔╝██╔═══██╗╚██╗██╔╝██║██╔══██╗██╔════╝
#   ███╔╝ ██║   ██║ ╚███╔╝ ██║██║  ██║█████╗  
#  ███╔╝  ██║   ██║ ██╔██╗ ██║██║  ██║██╔══╝  
# ███████╗╚██████╔╝██╔╝ ██╗██║██████╔╝███████╗
# ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝
#ANSI SHADOW#########################################

eval "$(zoxide init zsh)"
#╰─○ zoxide init --cmd cd zsh
# =============================================================================
## Utility functions for zoxide.
## pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}
# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}
# =============================================================================
# Hook configuration for zoxide.
# Hook to add new entries to the database.
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}
# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi
# When using zoxide with --no-cmd, alias these internal functions as desired.
#
__zoxide_z_prefix='z#'
# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"?* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@[-1]}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}
# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}
# Completions.
if [[ -o zle ]]; then
    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0
        if [[ "${#words[@]}" -eq 2 ]]; then
            _files -/
        elif [[ "${words[-1]}" == '' ]] && [[ "${words[-2]}" != "${__zoxide_z_prefix}"?* ]]; then
            \builtin local result
            # shellcheck disable=SC2086,SC2312
            if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" --interactive -- ${words[2,-1]})"; then
                result="${__zoxide_z_prefix}${result}"
                # shellcheck disable=SC2296
                compadd -Q "${(q-)result}"
            fi
            \builtin printf '\e[5n'
        fi
        return 0
    }
    \builtin bindkey '\e[0n' 'reset-prompt'
    [[ "${+functions[compdef]}" -ne 0 ]] && \compdef __zoxide_z_complete __zoxide_z
fi
\builtin alias cd=__zoxide_z
\builtin alias cdi=__zoxide_zi

#################################################
### ------------------------ ###
##   Z S H    - P R O M P T
### ------------------------ ###
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

	POWERLEVEL9K_MODE="nerdfont-complete"
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
################################################################################

