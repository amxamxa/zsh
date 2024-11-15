#!/usr/bin/env zsh
########################################################
## ___   ___ ALL RIGHTS BY max kempter ___   ___ 
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣  -NAME:	    zshrc.zsh
## ╚  ╩╩═╝╚═╝           ''''''''''''''''
##	 -PATH:    	/share/zsh/
##	 -STATUS:	work in progress
##	 -USAGE:	RC-File for zsh
## ____________________________________________________
##              󰌽   󰧻       󱚡    󰧼            
## ----------------------------------------------------
# FILE DATES	[yyyy-mmm-dd]ŝ
##..SAVE:	  	2024-...
##..CREATION:   2023
## ----------------------------------------------------
## 	set filetyte zsh
## COMMENTS:	nixOS-version
#####################################################
# Füge den Pfad für Custom- u Autoload-Funktionen hinzu. When we run a 
#command that corresponds to an autoloaded function, ZSH searches for 
#it in the “fpath” and loads it into the memory if located.
fpath=($ZDOTDIR:$ZDOTDIR/functions:$ZDOTDIR/plugins:$ZDOTDIR/prompts $fpath)

# History-Einstellungen
# ----------------------
export 	HISTIGNORE="ls:cd:pwd:exit:tldr:cheat:printf:micro:man:rm:cp:echo:z:bat:git:sudo:grep"
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
export BOLD="\e[1m" 
export RESET="\e[0m" 
export GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
export RED="\033[38;2;240;138;100m\033[48;2;147;18;61m" 
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
echo "--------------------------------------------------------" | blahaj -i -r
#	sleep 0.05
	source_or_error "$ZDOTDIR/functions/colors.zsh" &> /dev/null
#       source_or_error "$ZDOTDIR/prompt/purify.zsh"
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
	source_or_error "$ZDOTDIR/aliases.zsh"
	sleep 0.02
	source_or_error "$ZDOTDIR/plugins/zgreeting.zsh"

# eza-Einstellungen
export COLUMNS=78
export EZA_ICONS_AUTO="always"
export EZA_ICON_SPACING=2
export EZA_GRID_ROWS=3
export EZA_GRID_COLUMNS=3
export EZA_MIN_LUMINANCE=10
export EZA_COLORS=$LS_COLORS
# ------- ist in configuration.nix---------------------Projektpfade# TEALDEER_CONFIG_DIR="$ZDOTDIR/tldr"

#export PRO="/home/project"
#export NIX="/share/nixos/configurationNix"
#export S="/share"
#export KITTY_CONFIG_DIRECTORY="/share/kitty"
#export GIT_CONFIG="/share/git/config"
#export EMACSDIR="/share/emacs"
# 	GIT config
# export GIT_CONFIG="/share/git/config"
# 	BAT config
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
 eval "$(rg --generate=complete-zsh)"
  eval "$(mcfly init zsh)"
 # eval "$(colorless -a)"
  
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
#export STARSHIP_CONFIG="$ZDOTDIR/prompt/starship.toml" # Starship Prompt
export STARSHIP_CONFIG="$ZDOTDIR/prompt/starship.toml" # Starship Prompt v2
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
    alias zq='zoxide query'
    alias zqi='zoxide query -i'
    alias zr='zoxide remove'
    echo "\t${PINK} zoxide ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} zoxide ist nicht installiert. \
    Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
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
    export CHEAT_CONFIG_PATH="$ZDOTDIR/cheat/conf.yaml"
    echo "\t${GREEN} cheat  ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} cheat ist nicht installiert. }\n
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
    echo "${PINK} \t... bat als man-pager ... check ${RESET}\t"
else
    export MANPAGER="less -FRX --quit-if-one-screen --no-init"
    echo "less -FRX als man-pager  ... check ${RESET}"
fi
#	_________________________________________________

echo -e "\n\t${NIGHT}▄▀▄▀▄▀▄▀▄▀▄▀▄ u𝓈𝑒 𝓉𝒽𝒾𝓈 𝓀𝒾𝓉𝓉𝓎 𝓈𝒽𝑜𝓇𝓉𝒸𝓊𝓉𝓈 4 𝓀𝑒𝓎𝒷𝑜𝒶𝓇𝒹 𝓀𝓊𝓃𝑔-𝒻𝓊 ▀▄▀▄▀▄▀▄▀▄▀▄▀▄${RESET}" 
#echo -e "\n${SKY}	-----USE mxx kitty <3 Shortcutsreal :--------" # | blahaj -i -r
echo "  	 kitty_mod+(down)||(right)||(up) →  resize_window
         super+i →  set_tab_title"	| blahaj -w -c Nb				
echo -e "\n\t${NIGHT}▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄${RESET}"
echo "\t
	       alt+left →  layout_action move_to_screen_edge left
        alt+right →  layout_action move_to_screen_edge right
        alt+up →  layout_action move_to_screen_edge top
              
        ctrl+f5 →  background_opacity -0.1
        ctrl+f6 →  background_opacity +0.1
       
        kitty_mod+f12 →  launch--stdin-source=@screen_
        shift+f5 →  launch --type=overlay sh -c 'echo".."
       
        kitty_mod+b →  copy_to_buffer BUFFER
        kitty_mod+f →  copy_file_to_clipboard
        kitty_mod+f11 →  focus_visible_window
        kitty_mod+t →  launch --cwd=current --type=tab
	"| blahaj -w -c Nb


echo -e "\n\t${NIGHT}▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄${RESET}"
echo " 
  super+enter →  launch     --cwd=current 
        super+i →  set_tab_title
        super+t →  launch --cwd=current --type=tab

        shift+kp_add →  layout_action   bias 10 25
        shift+kp_divide →  toggle_layout  stack
        shift+kp_enter →  next_layout
        shift+kp_multiply →  launch   --cwd=current 
        super+kp_multiply →  new_tab
        shift+kp_subtract →  swap_with_window
        
        alt+f3 →  close_window
        alt+f6 →  close_tab
         
        ctrl+1 →  goto_layout   grid
        ctrl+2 →  goto_layout   stack
        ctrl+3 →  goto_layout  fat:bias=50
        ctrl+4 →  goto_layout   tall:bias=50
        ctrl+5 →  goto_layout   vertical
          
m"| blahaj -w -c Nb
echo -e "\n\t${NIGHT}▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄${RESET}"

# 	  Aktualisiere die Shell-Hash-Tabelle
#	--------------------------------------
# ...  häufig Programme installierst oder aktualisierst,
#  sicherstellt, dass deine Shell immer auf dem neuesten Stand ist
hash -r
### ------------------------------------------------------- ###



