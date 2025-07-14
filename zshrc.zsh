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
## 	set filetyte zsh
## COMMENTS:	nixOS-version
#####################################################
export RESET="\e[0m" 
export BOLD="\033[1m" 
export GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
export PINK="\033[38;2;255;0;53m\033[48;2;34;0;82m"
export RED="\033[38;2;240;138;100m\033[48;2;147;18;61m" 

# Füge den Pfad für Custom- u Autoload-Funktionen hinzu. When we run a 
#command that corresponds to an autoloaded function, ZSH searches for 
#it in the “fpath” and loads it into the memory if located.
fpath=($ZDOTDIR:$ZDOTDIR/functions:$ZDOTDIR/plugins:$ZDOTDIR/prompts $fpath)

# History-Einstellungen
# ----------------------
export 	HISTIGNORE="ls:cd:pwd:exit:tldr:cheat:printf:micro:man:eza:lsd:cp:echo:z:bap:bat:git:sudo:grep"
export 	HISTTIMEFORMAT="%D{%Y-%m-%d %H:%M} "

setopt 	EXTENDED_HISTORY    	# Zeitstempel speichern
setopt 	SHARE_HISTORY       	# History sofort speichern
setopt 	HIST_SAVE_NO_DUPS       # Do not write a duplicate event to the history file.
# unsetopt HIST_SAVE_NO_DUPS    # Write a duplicate event to the history file
setopt 	INC_APPEND_HISTORY 		# append the command without for shell exit

# To use the Meta or Alt keys, you probably need to revert to single-byte mode with a command such as:
unsetopt MULTIBYTE 		# Multibyte-Zeichensätze die mehr als ein Byte zur Darstellung benötigen

#	___________________________________________
#	       ZSH GLOBBING
### ------------------------------------------- 
setopt 		EXTENDEDGLOB	# for superglob for ls **/*.txt oder ls -d *(D)
unsetopt 	CASEGLOB
setopt 		ALIAS_FUNC_DEF 	# if set, aliases can be used for defining functions
setopt 		INTERACTIVE_COMMENTS 	# allow comments even in interactive shells
setopt 		PRINT_EXIT_VALUE		# print the exit value of programs with non-zero exit status
setopt 		RM_STAR_WAIT		# wait 10s and ignore anything typed, avoid problem
								# of reflexively answering ‘yes’ to the query: rm *
setopt 		sh_word_split	# split multi-word variables into individual elements
setopt 		notify		    # notifier for big jobs
unsetopt 	beep			# beep ausschalten

#	 _________________________________________
#   	     **ZSH DIRECTORY STACK** aka DS
# 	 -----------------------------------------
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
DIRSTACKSIZE=14
## wichtige Aliase für ZSH DIRECTORY STACK - DS
alias -g d='dirs -v'
for index ({1..14}) alias "$index"="cd -${index}"; unset index
setopt AUTO_CD   	# '..' statt 'cd ..'
REPORTTIME=3 		# display cpu usage, if command taking more than 3s
#	_________________________________________
# 		Initialisiere Autocompletion
# 	----------------------------- 
 # autoload command load a file containing shell commands
 # autoload looks in directories of the "_Zsh file search path_", defined in the 
 # variable `$fpath`, and search a file called `compinit`.
  autoload -Uz compinit; compinit
  _comp_options+=(globdots) 	# With hidden files

#  ___________________________________________________________

#	__________________________________________________________
#   ███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗
#   ██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝
#   ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗
#   ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝
#   ███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗
#   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝
#  _______________________________________________________
# export LS_COLORS="$(vivid generate jellybeans)"

# LS_COLORS mit benutzerdefinierter Farbdatei setzen
if [[ -f "$ZDOTDIR/colors/color-schema.yml" ]]; then
  if vivid_output="$(vivid generate "$ZDOTDIR/colors/color-schema.yml" 2>/dev/null)"; then
    export LS_COLORS="$vivid_output"
  else
    export LS_COLORS="$(vivid generate molokai)"
    printf "\t${GREEN}󰞷 .... vivid mit molokai${RESET}\n"
  fi
else
  export LS_COLORS="$(vivid generate molokai)"
  printf "\t${GREEN}󰞷 .... vivid mit molokai${RESET}\n"
fi

# eza-Einstellungen
export COLUMNS=78
export EZA_ICONS_AUTO="always"
export EZA_ICON_SPACING=2
export EZA_GRID_ROWS=3
export EZA_GRID_COLUMNS=3
export EZA_MIN_LUMINANCE=50
export EZA_COLORS="$LS_COLORS:hd=38;5;226:uu=38;5;202:gu=38;5;208:da=38;5;111:uR=38;5;197:uG=38;5;198"
# man eza_colors
# The codes accepted by eza are:       38;5;nnn  for a colour from 0 to  255
#   for i in {0..255}; do echo -e "\033[38;5;${i}m das ist TTTTEEEEXXT in Farbe ${i} \033[0m"; done            

# Funktion zum Sourcen von Dateien oder Ausgabe einer Fehlermeldung
source_or_error() {
    if [ -f "$1" ]; then
        source "$1"
        printf "\t${GREEN}󰞷 src pass:\t${RESET}${GELB}${BOLD}$1 ${RESET}\n"
    else
        printf "\t${RED}${BLINK} nicht gefunden!${RESET}${GELB}${BOLD} $1\t${RED}${BLINK} nicht gefunden! ${RESET}\n"
    fi
}
# Sourcen von Konfigurationsdateien
# echo "   󰞷 "
  echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
#	sleep 0.05
	source_or_error "$ZDOTDIR/plugins/zgreeting.zsh"
	source_or_error "$ZDOTDIR/functions/colors.zsh" # > /dev/null
#    source_or_error "$ZDOTDIR/prompt/purify.zsh"
	source_or_error "$ZDOTDIR/aliases.zsh"
	sleep 0.02
	source_or_error "$ZDOTDIR/plugins/shortcuts.zsh"
	sleep 0.03
	source_or_error "$ZDOTDIR/plugins/fzf.zsh"
	sleep 0.02
#	sleep 0.05
	source_or_error "$ZDOTDIR/plugins/fzf-key-bind.zsh"
	sleep 0.02
	source_or_error "$ZDOTDIR/functions/my-functions.zsh"
	sleep 0.02
# source_or_error "$ZDOTDIR/functions/zfunctions.zsh"
# 	sleep 0.02



# bereits-------in conf.nix
# --------------------------Projektpfade
#export PRO="/home/project"
#export NIX="/share/nixos/configurationNix"
#export S="/share"
#export KITTY_CONFIG_DIRECTORY="/share/kitty"
#export GIT_CONFIG="/share/git/config"
#export EMACSDIR="/share/emacs"
#export BAT_CONFIG_FILE="/share/bat/config.toml"

#--------------------------------------------

#-------------------------------- __-----------
#	                             /  |
#	  ______   __     __ ______  $$ |
#	 /      \ /  \   /  /      \ $$ |
#	/$$$$$$  |$$  \ /$$/$$$$$$  |$$ |
#	$$    $$ | $$  /$$/ /    $$ |$$ |
#	$$$$$$$$/   $$ $$/ /$$$$$$$ |$$ |
#	$$      |/   $$$/  $$    $$ |$$ |
#	 $$$$$$$/     $/    $$$$$$$/ $$/
#_____________________________________________
 eval "$(navi widget zsh)"   # mit "^g" fürs widget
 eval "$(hugo completion zsh)"
 eval "$(npm completion zsh)"
 #eval "$(rg --generate=complete-zsh)"
 
 # mcfly als CTRL + R
 # -----
 if command -v mcfly &> /dev/null; then
	 echo "\t${PINK} Mcfly  ... check ${RESET}\t"
	 eval "$(mcfly init zsh)"
	 export MCFLY_FUZZY=2 # 0 is off; Values in the 2-5 range get good results so far
	 export MCFLY_RESULTS=50
	 export MCFLY_DELETE_WITHOUT_CONFIRM=true
	 export MCFLY_INTERFACE_VIEW=BOTTOM
	 export MCFLY_RESULTS_SORT=LAST_RUN
	 export MCFLY_PROMPT="❯❯❯"
  else
     echo "\t${RED} Mc_Fly ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}\n"
 fi
 
# --------------------------------------------
#		████─████─████─█───█─████─███
#		█──█─█──█─█──█─██─██─█──█──█─
#		████─████─█──█─█─█─█─████──█─
#		█────█─█──█──█─█───█─█─────█─
#		█────█─█──████─█───█─█─────█─
#  ______ _____________________________________ 
# anderweitig in zsh.nix definiert:
# p10k-fancy.zsh ... ist das config-file:
# [[ ! -f "$ZDOTDIR/prompt/p10k-fancy.zsh" ]] || source "$ZDOTDIR/prompt/p10k-fancy.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
#if [[ -r "$ZDOTDIR/prompt/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 # source "$ZDOTDIR/prompt/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

#POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# ALTERNATIV zu POWERLEVEL9/10k- prompt:
# source /share/zsh/prompt/basic-prompt.zsh
#_______________________________________________________
# ggf. SPACESHIP PROMPT
#export STARSHIP_CONFIG="$ZDOTDIR/prompt/starship.toml"  # Starship Prompt v2
#export STARSHIP_CONFIG=$ZDOTDIR/prompt/pure.toml 		 # Alternative 1
#export STARSHIP_CONFIG=$ZDOTDIR/prompt/jetpack.toml 	 # Alternative 2
 export STARSHIP_CONFIG=$ZDOTDIR/prompt/purify.toml 	 # Alternative 3
 eval "$(starship init zsh)"
 eval "$(starship completions zsh)"
#	__________________________________________
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
# 	__________________________________________
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
    alias zq='zoxide query -l'
    #alias zqi='cd "$(zoxide query -i)"'
    alias zqi='cd "$(zoxide query -i)"'
    
    alias zr='zoxide remove'
    echo "\t${PINK} zoxide ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} zoxide ist nicht installiert. \
    Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
	sleep 0.2

fi
#	----------__------------_----------------
#		 ____/ /  ___ ___ _/ /_
#		/ __/ _ \/ -_) _ `/ __/
#		\__/_//_/\__/\_,_/\__/
#	------------------------------------------
# Prüfen, ob 'cheat' installiert ist
if command -v cheat &> /dev/null; then
    export CHEAT_USE_FZF="true"
    export CHEAT_CONFIG_PATH="$ZDOTDIR/cheat/conf.yaml"
    echo "\t${GREEN} cheat  ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} cheat ist nicht installiert. }\n
    Installieren Sie es ggf., um diese Funktionen zu nutzen.${RESET}"
   sleep 0.1
fi

# navi
if command -v navi &> /dev/null; then
  echo "\t${PINK} navi  ... check ${RESET}\t"
    if [[ -z ${NAVI_CONFIG+-v} ]]; then  #  Operator -z überprüft, ob der folgende String leer is, 
    # und +-v ist eine spezielle Syntax, um zu überprüfen, ob eine Variable existiert, und gleichzeitig einen Standardwert (-v) zurückzugeben, falls sie existiert.
	 export NAVI_CONFIG="$ZDOTDIR/navi"
	 echo "\t${GELB} NAVI_CONFIG wurde auf ${YELLOW}'$ZDOTDIR/navi'${GREEN} gesetzt. ${RESET}"
    else
     echo "\t${PINK} NAVI_CONFIG ist bereits gesetzt auf: ${YELLOW}'$NAVI_CONFIG'${GREEN}. ${RESET}"
fi
else
echo "\t${RED} navi ist nicht installiert. }\n
    Installieren Sie es ggf., um diese Funktionen zu nutzen.${RESET}"
sleep 0.1
fi
#   _________________________________________________________
#	╔═╗╔═╗╦ ╦    ╦ ╦╦╔═╗╦ ╦╦  ╦╔═╗╦ ╦╔╦╗╦╔╗╔╔═╗
#	╔═╝╚═╗╠═╣    ╠═╣║║ ╦╠═╣║  ║║ ╦╠═╣ ║ ║║║║║ ╦
#	╚═╝╚═╝╩ ╩────╩ ╩╩╚═╝╩ ╩╩═╝╩╚═╝╩ ╩ ╩ ╩╝╚╝╚═╝
#   _________________________________________________________
#	[  "main" "brackets" "pattern" "cursor" "regexp" "root" "line" ]
# source_or_error "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
 
 # ---Variante 1
  typeset -A ZSH_HIGHLIGHT_STYLES
 
 ZSH_HIGHLIGHT_STYLES[command]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[precommand]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#FFD75D'
 ZSH_HIGHLIGHT_STYLES[alias]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FFD75D'
 ZSH_HIGHLIGHT_STYLES[builtin]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[function]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#726D8F'
 ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#726D8F'
 ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#FFD75D'
 ZSH_HIGHLIGHT_STYLES[path]='fg=#DC8DF5'
 ZSH_HIGHLIGHT_STYLES[default]='none'
 ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#33E5E5'
 ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#33E5E5'
 ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#33E5E5'
 ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#33E5E5'
 ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#3AEB94'
 ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#3AEB94'
 ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#3AEB94'
 ZSH_HIGHLIGHT_STYLES[assign]='fg=#FFD75D'
 ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#FFD75D'
 ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#FFD75D'
 ZSH_HIGHLIGHT_STYLES[comment]='fg=#3AEB94'
 ZSH_HIGHLIGHT_STYLES[redirection]='fg=#786EC9'
 ZSH_HIGHLIGHT_STYLES[arg0]='fg=#3AEB94'
# ---Variante 2 
#  ZSH_HIGHLIGHT_STYLES=(
#     line="bold"
#     cursor="bg=blue"
#     alias="fg=magenta,bold"
#     path="fg=cyan"
#     globbing="none"
#     root="bg=red"
# )

# avoid partial path lookups on a path
#  		# ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(/mnt/slow_share)
 typeset -A ZSH_HIGHLIGHT_REGEXP
  		ZSH_HIGHLIGHT_REGEXP+=('^rm .*' fg=red,bold)
  		ZSH_HIGHLIGHT_REGEXP+=('\<sudo\>' fg=123,bold)
  		ZSH_HIGHLIGHT_REGEXP+=('[[:<:]]sudo[[:>:]]' fg=123,bold)
#	_________________________________________
#	KOSMETIK
rm -f  "$HOME/.xsession-errors "
rm -f  "$HOME/.xsession-errors.old"
rm -f  "$HOME/.ICEauthority"
rm -fr "$HOME/.compose-cache"

#	_________________________________________________
#	 less
#	------------------------------------------------
export LESS="--long-prompt --RAW-CONTROL-CHARS --ignore-case --quit-if-one-screen --quit-on-intr --no-init --mouse --hilite-search --hilite-unread"
# --RAW-CONTROL-CHARS: 	Steuerzeichen (wie Farbcodes) im Terminal korrekt anzuzeigen
# --chop-long-lines: 	Zeilen nicht umbrechen
# --no-init: 			verhindert, dass Bildschirm nach dem Verlassen löscht	
# --long-prompt:  		zeigt in der Statuszeile ausführliche Informationen 

# MANPAGER-Einstellungen
if command -v bat &> /dev/null; then
    export MANPAGER="bat --paging=always --style=changes -l man -p"
    echo "${GREEN} \t... bat als man-pager ... check ${RESET}\t"
else
    export MANPAGER="less -FRX --quit-if-one-screen --no-init"
    echo "less -FRX als man-pager  ... check ${RESET}"
fi
 
 echo " 󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"

# Wetteransage auf Console
 if command -v curl &> /dev/null; then
 	echo "\n${VIOLET}" && curl 'wttr.in/Dresden?m0&lang=de'
  else
    echo "\t${RED} curl ist nicht installiert. \
    Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
	sleep 0.2	
 fi 	

echo "        	    __              __              __      
	      ___  / /  ___   ____ / /_ ____ __ __ / /_  ___
	     (_-< / _ \/ _ \ / __// __// __// // // __/ (_-<
	    /___//_//_/\___//_/   \__/ \__/ \_,_/ \__/ /___/" |blahaj --colors=gay
 echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
 # echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"				
  echo "${BOLD}${NIGHT}\tctrl+1	\tg'rid
 \tctrl+2	\tstack
 \tctrl+3	\tfat:bias=50;full_size=1;mirrored=false
 \tctrl+4	\ttall:bias=50;full_size=1;mirrored=false 
 \tctrl+5	\tvertical ${RESET} "
  echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
 echo "${BOLD}  shift+KP_MULTIPLY	next_layout
  shift+KP_DIVIDE	swap_with_window
  shift+KP_SUBTRACT layout_action bias 10 25 40 55 75 85
  shift+KP_ENTER toggle_layout stack 
  shift+KP_ADD	launch --cwd=current --location=vsplit
  super+KP_ADD	launch --cwd=current --location=split
  super+enter 	launch --cwd=current --location=hsplit
  kitty_mod+t	launch --cwd=current --type=tab
  super+i 	set_tab_title  
  super+F9	pass_selection_to_program gnome-text-editor 
  		--ignore-session --standalone --new-window"
  echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
  echo "  ------------------------------------------------------
  CTRL+T:	preview file content using bat 
  CTRL+E:	edit selected file
  CRTL+R:	history widget or mc fly
  ALT +C:	print tree structure in the preview window
  CTRL+X CTRL+r history fzf widget
  CTRL+H 	fzf-man-widget
    ------------------------------------------------------
    CTRL+ALT+.   argument of the last commands  " |  clolcat -S 5 -F 0.06
# 	  Aktualisiere die Shell-Hash-Tabelle
#	--------------------------------------
# ...  häufig Programme installierst oder aktualisierst,
#  sicherstellt, dass deine Shell immer auf dem neuesten Stand ist
hash -r
### ------------------------------------------------------- ###



