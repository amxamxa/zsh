## 2024 Februar

theme.sh mellow-purple #https://github.com/lemnos/theme.sh


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
	# Suchbegriff mithilfe von fzf 
	# und zeigt die ausgewählte Man-Page an.
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

source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# aliases file
source "$ZDOTDIR/aliases.zsh"
# config für die "completion" gesourct
source "$ZDOTDIR/nix-zsh-completions/nix-zsh-completions.plugin.zsh"

fpath=($HOME/zsh/nix-zsh-completions $fpath)
autoload -U compinit && compinit

#prompt
 autoload -Uz promptinit
  promptinit
  prompt bigfade




# Workaround for nix-shell --pure
#if [ "$IN_NIX_SHELL" == "pure" ]; then
#    if [ -x "$HOME/.nix-profile/bin/powerline-go" ]; then
#        alias powerline-go="$HOME/.nix-profile/bin/powerline-go"
#    elif [ -x "/run/current-system/sw/bin/powerline-go" ]; then
#        alias powerline-go="/run/current-system/sw/bin/powerline-go"
#    fi
#fi


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



