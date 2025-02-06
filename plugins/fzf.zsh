#!/usr/bin/env zsh

########################################################
#	 ________  ________   ________ 
#	|\  _____\|\_____  \ |\  _____\
#	\ \  \__/  \|___/  /|\ \  \__/ 
#	 \ \   __\     /  / / \ \   __\
#	  \ \  \_|    /  /_/__ \ \  \_|
#	   \ \__\    |\________\\ \__\ 
#	    \|__|     \|_______| \|__| 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1.  	f z f 	config  	enviroment 
# 2.	f z f 	functions 	definition
# select multiple items with TAB 
# INHALT:
# CTRL+t:	preview file content using bat 
# CRTL+r: 	history widget
# ALT +c:	print tree structure in the preview window
# fzf zoxide

#	 HOW TOO
#  -----------
# Files under the current directory: 	nano  **<TAB>
# Files under parent directory: 	nano ../**<TAB>
# Files under parent dir, match `fzf`:	nano ../fzf**<TAB>
# Files under your home directory: 	nano ~/**<TAB>
# Directories under current directory:	cd **<TAB>
# Can select multiple processes with <TAB> or <Shift-TAB> keys:
#	kill -9 **<TAB>
#	export **<TAB> 
# 	setopt** #?

## ---------------- ##
##   f z f config   ##
## ---------------- ##

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'tree -FCshx {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"             "$@" ;;
    ssh)          fzf --preview 'dig {}'                       "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}'     "$@" ;;
  esac
}
# eval "$(fzf --zsh)" # Syntax 4 bash
source <(fzf --zsh) # Syntax 4  zsh

# 	  default
#	----------
# export FZF_COLORS='fg:124,bg:16,hl:202,fg+:214,bg+:52,hl+:231,info:52,prompt:196,spinner:208,pointer:196,marker:208'
# Molokai 		   'fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81,info:144,prompt:161,spinner:135,pointer:135,marker:118'
# Jellybeans  	   
 export FZF_COLORS='fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104,info:183,prompt:110,spinner:107,pointer:167,marker:215'
# oder Synthwave Cold
# export FZF_COLORS='bg+:#1a1a1a,bg:#131313,spinner:#ff69b4,hl:#ff99cc,fg:#ffa07a,header:#ff0033,info:#ffd700,pointer:#ff69b4,marker:#ff0033,prompt:#ffd700,hl+:#ff99cc,gutter:#ff0033'
 
export FZF_DEFAULT_OPTS="
		--height=60% 		 --info=inline \
		--margin=5%,2%,2%,2% --border=rounded  \
		--layout=reverse-list --color='$FZF_COLORS' \
		--prompt='∷ ' 	      --pointer='❯'	\
		--marker='☭'"
			#	--color=dark \
	#		--border-label "fzfmxx " \
	#		--header-lines='1'  \	
	#		--border-label-pos='-5' \
#	rounded		Rounded corners.	sharp		Sharp corners.
#	bold		Bold lines. 		double		Double lines.
#	horizontal	above and below.	vertical	left and right.
#	top, bottom, left, right		Only 1 border.
#	none		No border.     ->      --border
  export FZF_PREVIEW_ADVANCED="bat"
# rg (ripgrep) is a recursive line-oriented search tool. Aims to be a faster alternative to `grep`.
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# Setting fd as the default source for fzf, follow symbolic links and don't want it to exclude hidden 
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# 	 CTRL_T - Preview file content using bat (https://github.com/sharkdp/bat)
#	-------------------------------------------
	export FZF_CTRL_T_OPTS="
		  --walker-skip .git,node_modules,target
		  --preview 'bat -n --color=always {}'
		  --bind 'alt-t:change-preview-window(down|hidden|)'
		  --header	'alt-t to change preview'"
#  	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#	export FZF_CTRL_T_KEY='^[T' # Esc+T
#	_________________________________________________________
 
# 	  CTRL-R  - SEARCH HISTORY
#	---------------------------------
# alt-t CTRL-s to toggle small preview window to see the full command
# alt-c CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'alt-t:toggle-preview'
  --bind 'alt-c:execute-silent(echo -n {2..} | xclip -sel clip)+abort'
  --color header:italic
  --header 'COPY to clipboard: alt-c || Toggle preview: alt+t'"

# 	... oder ...
# use --preview option to display the full command on the preview window. In the following example, we bind ? key for toggling the preview window.
# export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
#__________________________________________________________
# 	  ALT_C - # Print tree structure in the preview window
#	----------
#export FZF_ALT_C_OPTS="		--walker-skip .git,node_modules,target \
 #	 	--preview 'bat {}' --bind 'alt-t:change-preview-window(right,70%|down,40%,border-horizontal|hidden|right)'"

export FZF_ALT_C_COMMAND='fd --type d --hidden -L -E .git'
export FZF_ALT_C_OPTS="--layout=reverse --height=100 --border --preview='tree -C {} | head -50'"


# ... oder (The following example uses tree command to show the entries of the directory.)
# export FZF_ALT_C_OPTS=" --preview 'tree -Cxh {} | head -n 10'"
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
#  fzf --preview 'cat {}' --bind 'ctrl-/:change-preview-window(right,70%|down,40%,border-horizontal|hidden|right)'

export FZF_COMPLETION_DIR_COMMANDS="
	cd z pushd \ 
	rmdir tree \ 	
	lsd eza"
# zoxide  mit fzf mit zqi
export _ZO_FZF_OPTS="
  --height 40% \
  --layout=reverse \
  --border \
  --preview 'exa --tree --level=2 {}' \
  --preview-window=right:50%:wrap \
  --color=dark"
 
# Directly executing the command (CTRL-X CTRL-R)
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept


## -------------------------- ##
##   f z f functions config   ##
## -------------------------- ##       

 function FZFedit()  {
	fzf --preview 'bat --color=always {}' --preview-window '~6' | xargs -o micro   	
	}	
	
fzf-man-widget() {
  batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
   man -k . | sort \
   | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
   | fzf  \
      -q "$1" \
      --ansi \
      --tiebreak=begin \
      --prompt=' Man > '  \
      --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
      --preview "${batman}" \
      --bind "enter:execute(man {1})" \
      --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
      --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
      --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
  zle reset-prompt
}
# `Ctrl-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
bindkey '^h' fzf-man-widget
zle -N fzf-man-widget
# Icon used is nerdfont							

# function FZFman()  {
	# Beschreibung: Durchsucht die Man-Pages nach  
	# Suchbegriff mithilfe fzf um ausgewählte Man-Page anzuzeigen
#	man -k . \
#	| fzf -q "$1" --prompt='man> ' --preview $'echo {} \
#	| tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' \
#	| xargs -r man'	\
#	| tr -d '()' \
#	| awk '{printf "%s ", $2} {print $1}' \
#	| xargs -r man  
 # }

function FZFsysctl()  {
	systemctl --no-legend --type=service --state=running \
	| fzf | awk '{print $1}' | 	xargs sudo systemctl restart			
	}

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
    fi                   
   }

