## 2024 Februar

theme.sh mellow-purple #https://github.com/lemnos/theme.sh



##############################################

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

#--------------------------------------------------------------------------------------------

### ------------------------------ ###
#    * *  S O U R C E plugins   * * ##
### ------------------------------ ###


# aliases file
#source "$ZDOTDIR/aliases.zsh"   


# config für die "completion" gesourct
source $HOME/zsh/nix-zsh-completions/nix-zsh-completions.plugin.zsh
fpath=($HOME/zsh/nix-zsh-completions $fpath)
autoload -U compinit && compinit






# Workaround for nix-shell --pure
#if [ "$IN_NIX_SHELL" == "pure" ]; then
#    if [ -x "$HOME/.nix-profile/bin/powerline-go" ]; then
#        alias powerline-go="$HOME/.nix-profile/bin/powerline-go"
#    elif [ -x "/run/current-system/sw/bin/powerline-go" ]; then
#        alias powerline-go="/run/current-system/sw/bin/powerline-go"
#    fi
#fi

#	 █████╗ ██╗     ██╗ █████╗ ███████╗███████╗███████╗
#	██╔══██╗██║     ██║██╔══██╗██╔════╝██╔════╝██╔════╝
#	███████║██║     ██║███████║███████╗█████╗  ███████╗
#	██╔══██║██║     ██║██╔══██║╚════██║██╔══╝  ╚════██║
#	██║  ██║███████╗██║██║  ██║███████║███████╗███████║
#	╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#		# https://manytools.org/hacker-tools/ascii-banner/


## ---------------------------  ## 
##  CAT/ BATCAT      
## ---------------------------  ## 

alias bat='bat -pp --terminal-width 76 --theme=ansi'
# gute themes für batcat ansi OneHalfDark Dracula Coldark-Dark
alias bat1='bat --force-colorization --terminal-width 76 --theme=ansi'
alias bat2='bat --force-colorization --terminal-width 76 --wrap=auto --theme=Dracula'
alias bat3='bat --number --terminal-width 76 --decorations=always --color=always --wrap=auto --theme=Coldark-Dark'
alias bat4='bat --number --terminal-width 76 --decorations=always --color=always --wrap=auto --theme=OneHalfDark'


#### --%%%%%%%%%%%%%%-- #####
###    globale aliase (zsh only)
###### --%%%%%%%%%%%%%%-- #####
alias -g SRC='source'
alias -g L='|less -X -j5 --tilde --save-marks --incsearch --RAW-CONTROL-CHARS --LINE-NUMBERS --line-num-width=3 --quit-if-one-screen --use-color --color=NWr --color=EwR  --color=PbC --color=Swb'
 alias -g G='|grep --ignore-case --color=auto' # ..usage$ file G pattern
 alias -g H='--help'
 
 #### --%%%%%%%%%%%%%%-- #####
 ###    aliase 
 ###### --%%%%%%%%%%%%%%-- #####

alias ZRC='micro $HOME/.zshrc && source $HOME/.zshrc'
alias -- -='cd -'
alias ..='cd ..'
alias BRC='nano $HOME/.bashrc && source $HOME/.bashrc'
alias BRCg='gedit $HOME/.bashrc &'
alias BSRC=''
alias COPYls='{ lsd | xargs -I {} echo {} | xargs -I {} echo {} | xclip -selection clipboard }'
alias EIN='sudo shutdown -r now'
alias FOR='fortune -e 50% debian-hints 30% debian 10% anarchism 10% ascii-art | lolcat'
alias Iad='ssh admin@8mai.cloud'
alias Iro='ssh root@212.227.183.196'
		
alias NIXconf='sudo gnome-text-editor /etc/nixos/configuration.nix &'
#alias NIX='sudo nano /etc/nixos/configuration.nix'
alias NIXHWcopy='cp /etc/nixos/hardware-configuration.nix $HOME/$(date +%F)_hardware-configuration.nix; lsd -ahl $HOME/*.nix'
alias NIXcopy='cp /etc/nixos/configuration.nix $HOME/$(date +%F)_configuration.nix; lsd -ahl $HOME/*.nix'
alias NIXenv='nix-env --query --installed'
alias NIXupt='sudo nixos-rebuild switch'
alias NIXinfo='nix-shell -p nix-info --run "nix-info -m"'

alias RSY='echo "sudo rsync --recursive --archive --update --copy-links --info=progress2  path/to/source path/to/ziel"'
alias _='sudo'
alias a2g='ali2g'
alias alais='alias'
alias ali2g='alias | grep --colour=always'
alias c='clear'
alias cd..='cd ..'
alias cp='cp -vdr'
alias env2g='printenv | grep --colour=always'
alias h='history'
alias h2g='history2grep'
alias h2gC='history2grepC'
alias history2grep='cat $HOME/.bash_history | grep --colour=always'
alias history2grepC='cat $HOME/.bash_history | grep --colour=always -c'
alias l="lsd -AlrhF --total-size" #'ls -Alrsh'
alias la='lsd -AFhr'
alias ld="lsd -dhrF */ && lsd -dhr .*/" #'lsd -dhr */'
alias lf='lsd -ltFrh --total-size --group-directories-first'
alias lh='lsd -dFhr .*'
alias ll='lsd -FAlhr --total-size --group-directories-first'

alias lolcat='clolcat'
alias ls='ls --color=auto'
alias md='mkdir -p'
alias mv='mv -vdr'
alias neofetch2='neofetch --config ~/.config/neofetch/config2.conf'

alias q='exit'
alias rm='rm -vdr'
alias sl='ls'
alias tdlr='tldr'

#### aliases
  ### NEW
alias d1=du -h --max-depth=1
alias d2= du -h --max-depth=2
#du -sh # Estimate file and directory space usage:
alias df='df -h' #Disk space usage in human-readable format
alias ll='echo -e "\t${PINK} LSD ${LILA} REVERSE ... mit  alles  ${GELB}in $(pwd)${PINK}(mit relativer  Zeit ohne Gruppenberechtigung): ${RESET}\t" &&	lsd --header --blocks 'permission' --blocks 'size'  --blocks 'links' --blocks 'name' --blocks 'user' --blocks 'date' \
	--total-size \
	--almost-all \
	--icon-theme 'fancy' \
	--human-readable \
	--date "relative" \
	--no-symlink  \
	--classify \
	--hyperlink 'always' \
	--long  \
	--size short \
	--group-dirs 'none' \
	--reverse
	'
	
alias lll='echo -e "\t${PINK} LSD ${LILA} REVERSE ... mit  alles  ${GELB}in $(pwd)${PINK} (mit absoluter Zeit und Gruppenberechtigung): ${RESET}\t" && lsd --date="+%d. %b %Y %H:%M Uhr" --long --header --blocks 'permission' --blocks 'size'  --blocks 'links' --blocks 'name' --blocks 'user' --blocks 'group' --blocks 'date' \
	--total-size \
	--almost-all \
	--icon-theme 'fancy' \
	--human-readable \
	--classify \
	--hyperlink 'always' \
	--long  \
	--size short \
	--group-dirs 'none' \
	--reverse
	'
	


## printf Ende
#printf "Hello, $(alias).\n\n" | clolcat  

##### --%%%%%%%%%%%%%%-- #####
##	                        ##
##	        g i t           ##
##	                        ##
##### --%%%%%%%%%%%%%%-- #####

# Git Status
alias gs='echo -e "${GELB}\nZeigt den Status des Arbeitsverzeichnisses und des Staging-Bereichs an${RESET}\n" && git status'

alias gss='echo -e "${PINK}\n\t git status --short ${RESET} with abbr.:${RESET}\n
${GELB}?? ... Untracked files${RESET}\t${GELB}U ... Files with merge conflicts${RESET}\t ${GELB}A ... New files added to staging ${RESET}\t${GELB}M ... Modified files${RESET}\t${GELB}D ... Deleted files${RESET}\t${GELB}R ... Renamed files${RESET}\t${GELB}C ... Copied files${RESET}\n" && git status -s'

#alias gss='cowsay "${GELB}\n git status --short w\:\n\t "M" for file is modified\n\t "A" for is new and has been added to staging \n\t "\?\? " indicates file is untracked.${RESET}\n" && git status -s'

# Git Add
alias ga='echo -e "${GELB}\nFügt Änderungen im Arbeitsverzeichnis zum Staging-Bereich hinzu${RESET}\n" && git add'

# Git Push
alias gp='echo -e "${GELB}\nPushed lokale Änderungen auf den Remote-Branch${RESET}\n" && git push'
alias gpo='echo -e "${GELB}\nPushed lokale Änderungen auf den Remote-Branch \"origin\"${RESET}\n" && git push origin'
alias gpof='echo -e "${GELB}\nForce-Pushed lokale Änderungen auf den Remote-Branch \"origin\" mit Lease-Check${RESET}\n" && git push origin --force-with-lease'
alias gpofn='echo -e "${GELB}\nForce-Pushed lokale Änderungen auf den Remote-Branch \"origin\" mit Lease-Check und ohne Verifizierung${RESET}\n" && git push origin --force-with-lease --no-verify'
alias gpt='echo -e "${GELB}\nPushed alle Tags auf den Remote-Branch${RESET}\n" && git push --tag'

# Git Tag
alias gtd='echo -e "${GELB}\nLöscht einen lokalen Tag${RESET}\n" && git tag --delete'
alias gtdr='echo -e "${GELB}\nLöscht einen Remote-Tag${RESET}\n" && git tag --delete origin'

# Git Branch
alias grb='echo -e "${GELB}\nZeigt die Remote-Branches an${RESET}\n" && git branch -r'
alias gb='echo -e "${GELB}\nZeigt alle Branches im aktuellen Repository an${RESET}\n" && git branch'

# Git Pull
alias gplo='echo -e "${GELB}\nHolt die neuesten Änderungen vom Remote-Branch \"origin\"${RESET}\n" && git pull origin'

# Git Commit
alias gc='echo -e "${GELB}\nErstellt einen Commit mit den im Staging-Bereich befindlichen Änderungen${RESET}\n" && git commit'

# Git Diff
alias gd='echo -e "${GELB}\nZeigt die Unterschiede zwischen Arbeitsverzeichnis und Staging-Bereich an${RESET}\n" && git diff'
alias gdc='echo -e "${GELB}\nZeigt die Unterschiede zwischen Staging-Bereich und letztem Commit an${RESET}\n" && git diff --cached'

# Git Checkout
alias gco='echo -e "${GELB}\nWechselt zu einem anderen Branch oder Commit${RESET}\n" && git checkout'

# Git Log
alias gll='echo -e "${GELB}\nFarbig formatierte Ausgabe der Commit-Historie in Graph-Darstellung${RESET}\n" && git log --graph --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)" --all'

alias gl='echo -e "${GELB}\nZeigt die Commit-Historie in einer Zeile an${RESET}\n" && git log --pretty=oneline'

alias glol='echo -e "${GELB}\nZeigt die Commit-Historie in einer graphischen Darstellung an${RESET}\n" && git log --graph --abbrev-commit --oneline --decorate'

# Git Remote
alias gr='echo -e "${GELB}\nZeigt die Namen der Remote-Repositories an${RESET}\n" && git remote'
alias grs='echo -e "${GELB}\nZeigt Informationen zu den Remote-Repositories an${RESET}\n" && git remote show'


#Der git for-each-ref Befehl listet Referenzen (refs) in einem Git-Repository auf, wie z.B. Branches, Tags und andere
  #  Aktueller Branch: Schnell erkennen, auf welchem Branch man sich gerade befindet (%(HEAD) zeigt ein Sternchen neben dem aktuellen Branch).
#    Branch-Übersicht: Eine Liste aller Branches im Repository erhalten.
#    Commit-Informationen: Sehen, welcher Commit zuletzt auf jedem Branch gemacht wurde, inklusive Commit-Hash, Nachricht, Autor und Datum.
alias gblog="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:red)%(refname:short)%(color:reset) - %(color:yellow)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:blue)%(committerdate:relative)%(color:reset))'"       





