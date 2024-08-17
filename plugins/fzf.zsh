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

## ---------------- ##
##   f z f config   ##
## ---------------- ##
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_CTRL_T_KEY='^[T' # Esc+T

export FZF_DEFAULT_OPTS="--height 60% \
	--border sharp \
	--layout reverse \
	--color '$FZF_COLORS' \
	--prompt '∷ ' \
	--pointer ▶ \
	--marker ⇒"
	
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
#export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"

export FZF_COMPLETION_DIR_COMMANDS="
	cd 	z pushd \ 
	rmdir tree \ 	
	lsd eza"
# 	#g+:-1,\

export FZF_COLORS="
	fg:magenta,\
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
# CTRL-s to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-s:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
  
export FZF_PREVIEW_ADVANCED="bat"

## -------------------------- ##
##   f z f functions config   ##
## -------------------------- ##       
_ZO_FZF_OPTS="\
--height 40% \
--layout=reverse \
--border \
--preview 'exa --tree --level=2 {}' \
--preview-window=right:50%:wrap \
--color=dark"
 function FZFedit()  {
	fzf --preview 'bat --color=always {}' --preview-window '~6' | xargs -o micro   	
	}	
							
function FZFman()  {
	# Beschreibung: Durchsucht die Man-Pages nach  
	# Suchbegriff mithilfe fzf um ausgewählte Man-Page anzuzeigen
	man -k . \
	| fzf -q "$1" --prompt='man> ' --preview $'echo {} 		\
	| tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' 	\
	| xargs -r man' 										\
	| tr -d '()' 											\
	| awk '{printf "%s ", $2} {print $1}' 					\
	| xargs -r man  
  }

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
