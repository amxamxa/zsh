#!/usr/bin/env zsh
##########################################
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣  -NAME:	    fff-fuck.zsh
## ╚  ╩╩═╝╚═╝           ''''''''''''''''
##	 -PATH:    	/share/zsh/
##	 -STATUS:	work in progress
##	 -USAGE:	RC-File fff and fuck 

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
    TF_CMD=$(thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@) && eval $TF_CMD # Der Befehl `thefuck` wird mit den übergebenen Argumenten ausgeführt und das Ergebnis wird in der Variable TF_CMD gespeichert
    unset TF_HISTORY
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING
    test -n "$TF_CMD" && print -s $TF_CMD    # Wenn TF_CMD nicht leer ist, wird der Befehl in der Variable TF_CMD als Shell-Befehl ausgegeben
}


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
		export FFF_CD_ON_EXIT=1
	# w3m-img offsets.
	export FFF_W3M_XOFFSET=40
	export FFF_W3M_YOFFSET=0
	
	export FFF_FAV1=$HOME
	export FFF_FAV2=/home/projects
	export FFF_FAV3=/share
	export FFF_FAV4=/share/wallpaper

	
