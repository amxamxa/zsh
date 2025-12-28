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
# unsetopt HIST_SAVE_NO_DUPS    # Write a duplicate event to the history file

# To use the Meta or Alt keys, you probably need to revert to single-byte mode with a command such as:
unsetopt MULTIBYTE 		# Multibyte-Zeichensätze die mehr als ein Byte zur Darstellung benötigen
unsetopt CASEGLOB

#  ___________________________________________________________

#	__________________________________________________________
#   ███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗
#   ██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝
#   ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗
#   ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝
#   ███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗
#   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝
#  _______________________________________________________
# Vivid color configuration: LS_COLORS mit benutzerdefinierter Farbdatei setzen
# export LS_COLORS="$(vivid generate alabaster_dark)" #jellybeans)" #  ayu rose-pine-moon snazzy
if [[ -f "$ZDOTDIR/colors/color-schema.yml" ]]; then
  if vivid_output="$(vivid generate "$ZDOTDIR/colors/color-schema.yml" 2>/dev/null)"; then
    export LS_COLORS="$vivid_output"
  else
    export LS_COLORS="$(vivid generate molokai)"
    printf "\t${GREEN}󰞷 .... vivid mit molokai${RESET}\n"
  fi
else
  export LS_COLORS="$(vivid generate alabaster_dark)"
  printf "\t${GREEN}󰞷 .... vivid mit alabaster_dark ${RESET}\n"
fi

# Function to source files with error handling
source_or_error() {
    local file="$1"
    local error_output
    if [[ ! -f "$file" ]]; then
        printf "\t${RED}${BLINK}󰅙 nicht gefunden!${RESET}${GELB}${BOLD} $file${RESET}\n" >&2
        return 1
    fi
    if error_output=$(source "$file" 2>&1); then
        printf "\t${GREEN}󰞷 src pass:\t${RESET}${GELB}${BOLD}$file${RESET}\n"
        return 0
    else
        printf "\t${RED}${BLINK}󰅙 Fehler beim Laden!${RESET}${GELB}${BOLD} $file${RESET}\n" >&2
        printf "\t${RED}Details: $error_output${RESET}\n" >&2
        return 1
    fi
}

# Sourcen von Konfigurationsdateien
# echo "   󰞷 "
echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
# Source configuration files
#    source_or_error "$ZDOTDIR/prompt/purify.zsh"
source_or_error "$ZDOTDIR/functions/zgreeting.zsh"
source_or_error "$ZDOTDIR/aliases.zsh"
sleep 0.02
source_or_error "$ZDOTDIR/functions/shortcuts.zsh"
sleep 0.03
source_or_error "$ZDOTDIR/functions/fff-fuck.zsh"
sleep 0.02
source_or_error "$ZDOTDIR/functions/my-functions.zsh"
sleep 0.02
source_or_error "$ZDOTDIR/functions/zfunctions.zsh"
source_or_error "$ZDOTDIR/fzf/fzf-tools.zsh"
sleep 0.02

# /share/zsh/plugins/term-theme.zsh #in .zshrc integriert!
# source_or_error "$ZDOTDIR/plugins/tetris.zsh
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

# Initialize completion systems with error handling
if command -v navi &> /dev/null; then
    eval "$(navi widget zsh)"
fi

if command -v hugo &> /dev/null; then
    eval "$(hugo completion zsh)"
fi

if command -v npm &> /dev/null; then
    eval "$(npm completion zsh)"
fi

if command -v navi &> /dev/null; then
    eval "$(rg --generate=complete-zsh)"
fi

#	__________________________________________
#		  __ _  (_)__________ 
#		 /  ' \/ / __/ __/ _ \
#	 	/_/_/_/_/\__/_/  \___/
#	 -----------------------------------------
# Micro editor configuration
if command -v micro &> /dev/null; then
    export MICRO_CONFIG_HOME="/share/micro"
    echo "\t${GREEN} micro  ... check ${RESET}\t"
else
    echo "\t${RED} micro ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
fi
# 	__________________________________________
#		__ __    .___ ___
#		 //  \\_/||  \|__
#		/_\__// \||__/|___
# 	 -----------------------------------------
# Prüfen, ob 'zoxide' installiert ist, Zoxide configuration
if command -v zoxide &> /dev/null; then
    export _ZO_ECHO=1
    export _ZO_DATA_DIR="$ZDOTDIR/zoxide"
    eval "$(zoxide init zsh)"
    alias za='zoxide add'
    alias zq='zoxide query -l'
    alias zqi='cd "$(zoxide query -i)"'
    alias zr='zoxide remove'
    echo "\t${PINK} zoxide ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} zoxide ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
    sleep 0.2
fi
#	----------__------------_----------------
#		 ____/ /  ___ ___ _/ /_
#		/ __/ _ \/ -_) _ `/ __/
#		\__/_//_/\__/\_,_/\__/
#	------------------------------------------
# Prüfen, ob 'cheat' installiert ist, Cheat configuration
if command -v cheat &> /dev/null; then
    export CHEAT_USE_FZF="true"
    export CHEAT_CONFIG_PATH="$ZDOTDIR/cheat/conf.yaml"
    echo "\t${GREEN} cheat  ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} cheat ist nicht installiert. Installieren Sie es ggf., um diese Funktionen zu nutzen.${RESET}"
    sleep 0.1
fi

# Navi configuration  # mit "^g" fürs widget

if command -v navi &> /dev/null; then
    echo "\t${PINK} navi  ... check ${RESET}\t"
    if [[ -z ${NAVI_CONFIG+x} ]]; then
        export NAVI_CONFIG="$ZDOTDIR/navi"
        echo "\t${GELB} NAVI_CONFIG wurde auf ${YELLOW}'$ZDOTDIR/navi'${GREEN} gesetzt. ${RESET}"
    else
        echo "\t${PINK} NAVI_CONFIG ist bereits gesetzt auf: ${YELLOW}'$NAVI_CONFIG'${GREEN}. ${RESET}"
    fi
else
    echo "\t${RED} navi ist nicht installiert. Installieren Sie es ggf., um diese Funktionen zu nutzen.${RESET}"
    sleep 0.1
fi

 
 # mcfly als CTRL + R
 # ----- 
 #  if command -v mcfly &> /dev/null; then
	#  echo "\t${PINK} Mcfly  ... check ${RESET}\t"
	#  eval "$(mcfly init zsh)"
	#  export MCFLY_FUZZY=2 # 0 is off; Values in the 2-5 range get good results so far
	#  export MCFLY_RESULTS=50
	#  export MCFLY_DELETE_WITHOUT_CONFIRM=true
	#  export MCFLY_INTERFACE_VIEW=BOTTOM
	#  export MCFLY_RESULTS_SORT=LAST_RUN
	#  export MCFLY_PROMPT="❯❯❯"
 #  else
 #     echo "\t${RED} Mc_Fly ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}\n"
 # fi
 # 
# --------------------------------------------
#		████─████─████─█───█─████─███
#		█──█─█──█─█──█─██─██─█──█──█─
#		████─████─█──█─█─█─█─████──█─
#		█────█─█──█──█─█───█─█─────█─
#		█────█─█──████─█───█─█─────█─
#  ______ _____________________________________ 
# anderweitig in zsh.nix definiert:
#[[ ! -f /share/zsh/.p10k.zsh ]] || source /share/zsh/.p10k.zsh

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
 # export STARSHIP_CONFIG=$ZDOTDIR/prompt/purify.toml 	 # Alternative 3
# eval "$(starship init zsh)"
#  eval "$(starship completions zsh)"




#	 less
#	------------------------------------------------
# --RAW-CONTROL-CHARS: 	Steuerzeichen (wie Farbcodes) im Terminal korrekt anzuzeigen
# --chop-long-lines: 	Zeilen nicht umbrechen
# --no-init: 			verhindert, dass Bildschirm nach dem Verlassen löscht	
# --long-prompt:  		zeigt in der Statuszeile ausführliche Informationen 
export LESS="--long-prompt --RAW-CONTROL-CHARS --ignore-case --quit-if-one-screen --quit-on-intr --no-init --mouse --hilite-search --hilite-unread"

# Manpager configuration
if command -v bat &> /dev/null; then
    export MANPAGER="bat --paging=always --style=changes -l man -p"
    echo "${GREEN} \t... bat als man-pager ... check ${RESET}\t"
else
    export MANPAGER="less -FRX --quit-if-one-screen --no-init"
    echo "less -FRX als man-pager  ... check ${RESET}"
fi

echo " 󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"

# Weather display
if command -v curl &> /dev/null; then
    echo "\n${VIOLET}" && curl 'wttr.in/Dresden?m0&lang=de'
else
    echo "\t${RED} curl ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
    sleep 0.2	
fi

echo "        	    __              __              __      
	      ___  / /  ___   ____ / /_ ____ __ __ / /_  ___
	     (_-< / _ \/ _ \ / __// __// __// // // __/ (_-<
	    /___//_//_/\___//_/   \__/ \__/ \_,_/ \__/ /___/" |blahaj --colors=gay
 echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
 # echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"				
 table.sh ./kitty-keys.txt 
 # echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
 #echo "${BOLD}  shift+KP_MULTIPLY	next_layout
  # shift+KP_DIVIDE	swap_with_window
  # shift+KP_SUBTRACT layout_action bias 10 25 40 55 75 85
  # shift+KP_ENTER toggle_layout stack 
  # shift+KP_ADD	launch --cwd=current --location=vsplit
  # super+KP_ADD	launch --cwd=current --location=split
  # super+enter 	launch --cwd=current --location=hsplit
  # kitty_mod+t	launch --cwd=current --type=tab
  # super+i 	set_tab_title  
  # super+F9	pass_selection_to_program gnome-text-editor 
  # 		--ignore-session --standalone --new-window"
  # 
  echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"
  
# Display kitty keybindings table
if [[ -f "$ZDOTDIR/functions/table.sh" && -f "./kitty-keys.txt" ]]; then
    "$ZDOTDIR/functions/table.sh" ./kitty-keys.txt
fi

echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj -i --colors="aroace"

# FZF documentation info
echo "${PINK} fzf documentation: $ZDOTDIR/fzf/README.md${RESET}"
echo " Ctrl+M	fzf-command-widget → Kontextabhängig fzf für ls, man, grep, find, ps aux
 Ctrl+R	Zsh-History-Suche → mit fzf-run-cmd-from-history
 Ctrl+E	Select File and edit w/ \$EDITOR " | clolcat -S 5 -F 0.06

echo " --------------------------------------------------
         CTRL+ALT+.   argument of the last commands  " | blahaj -r -i

# 	  Aktualisiere die Shell-Hash-Tabelle
#	--------------------------------------
# ...  häufig Programme installierst oder aktualisierst,
#  sicherstellt, dass deine Shell immer auf dem neuesten Stand ist
hash -r

#  KOSMETIK
rm -f  "$HOME/.xsession-errors "
rm -f  "$HOME/.xsession-errors.old"
rm -f  "$HOME/.ICEauthority"
rm -fr "$HOME/.compose-cache"

