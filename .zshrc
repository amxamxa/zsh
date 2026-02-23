###################################################
## ╔═╗╦╦  ╔═╗           ________________
## ╠╣ ║║  ║╣  -NAME:	    .zshrc
## ╚  ╩╩═╝╚═╝           ''''''''''''''''
##	 -PATH:    	/share/zsh/
##	 -STATUS:	work in progress
##	 -USAGE:	RC-File for zsh
## -------------------------------------
## -----------------------------------------
## 	set filetyte zsh
## COMMENTS:	nixOS-version
#####################################################          
echo -e " \t ______    ______ \t\t\n         / / / /   / /\ \ \ \t\t\n        / / / /   / /  \ \ \ \t\t\n        \ \ \\  / /   / / / \t\t\n         \_\_\_\/_/   /_/_/ \t\t\n
" | lolcat --animate --duration 2
 
# man eza_colors
# The codes accepted by eza are:       38;5;nnn  for a colour from 0 to  255
#   for i in {0..255}; do echo -e "\033[38;5;${i}m das ist TTTTEEEEXXT in Farbe ${i} \033[0m"; done

# To use the Meta or Alt keys, you probably need to revert to single-byte mode with a command such as:
#unsetopt MULTIBYTE 		# Multibyte-Zeichensätze die mehr als ein Byte zur Darstellung benötigen
#unsetopt CASEGLOB
# unsetopt HIST_SAVE_NO_DUPS    # Write a duplicate event to the history file


## ZDOTDIR
##export ZDOTDIR="/share/zsh/"
##export ZFUNCDIR="/share/zsh/functions"

# Vivid color configuration: LS_COLORS mit benutzerdefinierter Farbdatei setzen
# export LS_COLORS="$(vivid generate alabaster_dark)" #jellybeans)" #  ayu rose-pine-moon snazzy

if [[ -f "$ZDOTDIR/colors/color-schema.yml" ]]; then
  if vivid_output="$(vivid generate "$ZDOTDIR/colors/color-schema.yml" 2>/dev/null)"; then
    export LS_COLORS="$vivid_output"
  else
    #export LS_COLORS="$(vivid generate snazzy)"
    #printf "\t${GREEN}󰞷 .... vivid mit snazzy${RESET}\n"
    export LS_COLORS="$(vivid generate rose-pine-moon)"
    printf "\t${GREEN}󰞷 .... vivid mit rose-pine-moon ${RESET}\n"
  fi
else
  export LS_COLORS="$(vivid generate alabaster_dark)"
  printf "\t${GREEN}󰞷 .... vivid mit alabaster_dark ${RESET}\n"
fi

# _____________________________________________________


#______________________________________________________
#   ███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗
#   ██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝
#   ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗
#   ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝
#   ███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗
#   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝
# Function: source_or_error
# Purpose : Safely source .sh / .zsh files with extensive validation
# Usage   : source_or_error file.sh|file.zsh
source_or_error() {
  # --- UI colors (ANSI) ---
  local RED="\033[38;2;240;128;128m\033[48;2;139;0;0m"
  local GELB="\e[33m"
  local GREEN="\033[38;2;0;255;0m\033[48;2;0;100;0m"
  local RESET="\e[0m"

  # --- logging helper ---
  _log() {
    # $1 = level, , $2 = filename $3 = message
   printf "[%s] %-12s %-5s %s\n" "$(date '+%c')" "$1" "$2" "$3"  >> "$ZDOTDIR/zsh.log" 1> /dev/null
    }

  local file="$1"
  # Validation checks
    # --- argument sanity ---
  [[ -z "$file" ]] && { _log ERROR "" "No file argument provided"; return 2; }
    # --- existence (any type) ---
  [[ ! -e "$file" ]] && { _log ERROR "" "File does not exist: $file"; return 3; }
    # --- empty file check ---
  [[ ! -s "$file" ]] && { _log ERROR "" "File is empty: $file"; return 4; }
    # is file?
  [[ ! -f "$file" ]] && { _log ERROR "" "Not a regular file: $file"; return 5; }
    # is readable?
  [[ ! -r "$file" ]] && { _log ERROR "" "File not readable: $file"; return 6; }

  # --- symlink handling ---
  if [[ -L "$file" ]]; then
    local real_file="${file:A}"
    _log INFO "" "Symlink resolved: $file -> $real_file"
    printf "\t${GELB}→ Symlink resolved: $real_file${RESET}\n"
    file="$real_file"
  fi
 # --- extension whitelist ---
  case "$file" in
    (*.sh|*.zsh|*.zsh-theme)
      _log INFO "" "Accepted extension"
      ;;
    (*)
      _log ERROR "" "Unsupported extension: $file"
      printf "\t${RED}✖ Unsupported file type (only .sh/.zsh allowed): $file${RESET}\n"
      return 7
      ;;
  esac
  # --- basic plausibility (optional syntax probe) ---
  # Note: zsh has no true "lint"; this catches gross parser errors
 # if ! zsh -n "$file" 2>/dev/null; then
 #   _log ERROR "" "Syntax check failed: $file"
 #   printf "\t${RED}✖ Syntax check failed: $file${RESET}\n"
 #   return 8
  # fi
  # --- source ---
  _log INFO "" "Sourcing file: $file"
  source "$file"

  local rc=$?
  if (( rc != 0 )); then
    _log ERROR "" "Sourcing returned non-zero exit code ($rc): $file"
    printf "\t${RED}✖ Error while sourcing: $file${RESET}\n"
    return $rc
  fi
  printf "${MINT}󰞷 src pass: ${CYAN} $file :${SLATE} ✔ ${RESET}\n"
#  printf "${GREEN}󰞷 src pass: ${NIGHT} $file :${GREEN} ✔ ${RESET}\n"
  return 0
}
#----------------------------------------------------------------------

# bereits-------in enviroment.nix----------Projektpfade
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

# Initialize completion systems with error handling -  Tool-specific completions
command -v navi &>/dev/null && eval "$(navi widget zsh)"
command -v hugo &>/dev/null && eval "$(hugo completion zsh)"
command -v npm &>/dev/null && eval "$(npm completion)"
command -v rg &>/dev/null && eval "$(rg --generate=complete-zsh)"
command -v glow  &>/dev/null && eval "$(glow completion zsh)"
command -v pay-respects &>/dev/null && eval "$(pay-respects zsh)"
#	__________________________________________
#		  __ _  (_)__________ 
#		 /  ' \/ / __/ __/ _ \
#	 	/_/_/_/_/\__/_/  \___/
# Micro editor configuration
if command -v micro &> /dev/null; then
    export MICRO_CONFIG_HOME="/share/micro"
    echo "\t${GREEN} micro  ... check ${RESET}\t"
	alias edit="micro"
else
    echo "\t${RED} micro ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
fi
# 	__________________________________________
#		__ __    .___ ___
#		 //  \\_/||  \|__
#		/_\__// \||__/|___
# Prüfen, ob 'zoxide' installiert ist, Zoxide configuration
if command -v zoxide &> /dev/null; then
    export _ZO_ECHO=1
    export _ZO_DATA_DIR="$ZDOTDIR/zoxide"
    eval "$(zoxide init zsh)"
    alias zq='zoxide query -l'
    alias zqi='cd "$(zoxide query -i)"'
    echo "\t${PINK} zoxide ... check ${RESET}\t"
  else
    echo "\t${RED} zoxide ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
    sleep 1
fi
#	----------__------------_----------------
#		 ____/ /  ___ ___ _/ /_
#		/ __/ _ \/ -_) _ `/ __/
#		\__/_//_/\__/\_,_/\__/
# Prüfen, ob 'cheat' installiert ist, Cheat configuration
if command -v cheat &> /dev/null; then
    export CHEAT_USE_FZF="true"
    export CHEAT_CONFIG_PATH="$ZDOTDIR/cheat/conf.yaml"
    echo "\t${GREEN} cheat  ... check ${RESET}\t"
    sleep 0.1
else
    echo "\t${RED} cheat ist nicht installiert. Installieren Sie es ggf., um diese Funktionen zu nutzen.${RESET}"
    sleep 2.1
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
    sleep 1
fi

#------------------------------------------                                 
#     oooooo         o         o        
#       8   .oPYo.  o8P oPYo. o8 .oPYo. 
#       8   8oooo8   8  8  `'  8 Yb..   
#       8   8.       8  8      8   'Yb. 
#       8   `Yooo'   8  8      8 `YooP' 
#    :..::..:::.....:::..:..:::::..:.....:
# play Tetris in Shell, pree H for navigation
autoload -Uz tetriscurses
alias tetris=tetriscurses

#-------------------------------------------
# McFly für History Mgmt 
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
# PROMPT: siehe ZFUNC
#----FALLBACK 2:------------------ZSH NATIVE PROMPT-----------------------------
#    powerlevel10k_plugin_unload
#    prompt off
#    setopt prompt_subst
#    autoload -Uz colors && colors
#    PROMPT='%F{184}%n%f@%F{013}%m%f%F{025}%K{118} in %k%f%F{225}%K{055}%~%f%k%F{063}%K{045} --> %k%f'
#    RPROMPT='|%F{#FFCA5B}ERR:%?|%F{#CF36E8}%K{#39257D}%f%k%K{#3B0045}%F{#518EA9}%D{%e.%b.}%f%k%F{#FFEAA0}%K{#1E202C}%f%k|%F{#FFEAA0}%K{#95235F}%D{%R}%f%k%F{#FFCA5B}|'
#    _log WARNING "Using minimal fallback prompt; install starship or powerlevel10k for richer prompt"


# --- Pager Configuration ---
export PAGER="less -R"
# --RAW-CONTROL-CHARS: Steuerzeichen (wie Farbcodes) korrekt anzeigen
# --chop-long-lines: 	Zeilen nicht umbrechen
# --no-init: 		Bildschirm nicht löschen	
# --long-prompt:  	Statuszeile verbose
export LESS="--long-prompt --RAW-CONTROL-CHARS --ignore-case --quit-if-one-screen --quit-on-intr --no-init --mouse --hilite-search --use-color -Dd+r -Du+b"

# Manpager configuration------------------------
export MANROFFOPT="-c"
export MANWIDTH="60"
if command -v bat &> /dev/null; then
 #   export MANPAGER="bat --paging=always --style=changes -l man -p"
   export  MANPAGER='sh -c "col -bx | bat --paging=always --style=changes -l man"'
   echo "${GREEN} \t... bat als man-pager ... check ${RESET}\t"
else
    export MANPAGER="less -FRX --quit-if-one-screen --no-init"
    echo "${GELB} less -FRX als man-pager  ... check ${RESET}"
      # Enable color support for less via Termcap sequences
  export LESS_TERMCAP_mb="\e[1;31m"; # Start blinking
  export LESS_TERMCAP_md="\e[1;36m"; # Start bold (Cyan)
  export LESS_TERMCAP_me="\e[0m";    # End bold/blink
  export LESS_TERMCAP_so="\e[01;44;33m"; # Start standout (Yellow on Blue)
  export LESS_TERMCAP_se="\e[0m";    # End standout
  export LESS_TERMCAP_us="\e[1;32m"; # Start underline (Green)
  export LESS_TERMCAP_ue="\e[0m";    # End underline

fi
# --------------------------------------------
echo " 󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj --individual --colors="aroace"

# Weather display------------------------------------------
#if command -v curl &> /dev/null; then
#    echo "\n${VIOLET}" && curl 'wttr.in/Dresden?m0&lang=de'
#else
#    echo "\t${RED} curl ist nicht installiert. Bitte installieren Sie es, um diese Funktionen zu nutzen.${RESET}"
#    sleep 0.2	
# fi
#--------------------------------------------------
# Sourcen von Konfigurationsdateien
# echo "   󰞷 "
echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj --individual --colors="aroace"
# Source configuration files
source_or_error "$ZDOTDIR/aliases.zsh"
#source_or_error "/etc/zsh/aliases.sh"
#source_or_error "/etc/zsh/logging-aliases.sh"
#source_or_error "/etc/zsh/zsh-highlight-styles.zsh"
#source_or_error "/etc/zsh/fzf-config.sh"
source_or_error "$ZDOTDIR/functions/shortcuts.zsh"
source_or_error "$ZDOTDIR/functions/fff.zsh"
source_or_error "$ZDOTDIR/functions/zfunctions.zsh"
source_or_error "$ZDOTDIR/functions/my-functions.zsh"
source_or_error "$ZDOTDIR/functions/my-functions.sh"
source_or_error "$ZDOTDIR/functions/zgreeting.zsh"
# source_or_error "$ZDOTDIR/functions/batNoComment.sh"
 # colors.sh ->bin
 source_or_error "$ZDOTDIR/functions/cowmuh.sh"
 #fff-fuck.zsh
 #genPlaylist.sh
 #how.sh
 #kitty-keys.txt
 #mopen.sh
 #my-functions.sh
 #my-functions.zsh
 #NIXwo.sh
 #prompt-selector
 #shortcuts.zsh
 #table.sh
 #term-theme.zsh
 #tetris.zsh
 #Trash.sh
 #window.sh
 #zfunctions.zsh
 #zgreeting.zsh
 #zshColorThemeSwitcher.sh
 source_or_error "$ZDOTDIR/functions/zshCopyCmdToNote.sh"
 source_or_error /run/current-system/sw/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
 source_or_error  $ZDOTDIR/prompt/p10k.zsh
# source_or_error "$ZDOTDIR/functions/prompt-selector.zsh"
# Source alle Skripte aus /share/zsh/functions
#for script in $ZDOTDIR/functions/*.{sh,zsh} 
#for script in $ZDOTDIR/functions/"*.zsh" 
#  if [[ -f "$script" && -r "$script" ]]; then
 #    source_or_error "$script"
# fi
#done
   
#   source $ZDOTDIR/prompt/p10k.zsh 2>/dev/null
#  source_or_error "$script"

# source_or_error "$ZDOTDIR/fzf/fzf-tools.zsh"
# source_or_error "$ZDOTDIR/fzf/fzf-mxx.zsh"
# /share/zsh/plugins/term-theme.zsh #in .zshrc integriert!
# source_or_error "$ZDOTDIR/plugins/tetris.zsh
 	sleep 1
 	clear
# =================================

echo "󰞷 <><><><><><><><><><><><><><><><><><><><><><><><><><><><><>󰞷" | blahaj --individual --colors="gay"		   
showImg "/etc/nixos/assets/shortcuts.png" || chafa "/etc/nixos/assets/shortcuts.png"
echo
echo
echo
echo
echo "󰞷 <><><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj --individual --colors="gay"			
# Display kitty keybindings table
if [[ -f "$HOME/bin/table.sh" ]]; then
    $HOME/bin/table.sh $HOME/bin/kitty-keys.txt
fi
 # echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj --individual --colors="aroace"

echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj --individual --colors="aroace"

# FZF documentation info
#echo "${PINK} fzf documentation: $ZDOTDIR/fzf/README.md${RESET}"
# echo " Ctrl+M	fzf-command-widget → Kontextabhängig fzf für ls, man, grep, find, ps aux
# Ctrl+R	Zsh-History-Suche → mit fzf-run-cmd-from-history
# Ctrl+E	Select File and edit w/ \$EDITOR " | clolcat -S 5 -F 0.06

echo -e " --------------------------------------------------
  convert to UPPERCASE [lowercase] ---> ALT+U\+L
  argument of last commands     --> CTRL+ALT+.
  kill the word at the cursor --> ALT+D" | blahaj --random --words
echo "  󰞷  <><><><><><><><><><><><><><><><><><><><><><><><><><><><> 󰞷 " | blahaj --individual --colors="aroace"
  
# 	  Aktualisiere die Shell-Hash-Tabelle
#	--------------------------------------
# ...  häufig Programme installierst oder aktualisierst,
#  sicherstellt, dass deine Shell immer auf dem neuesten Stand ist
hash -r

#  KOSMETIK
rm -f  "$HOME/.xsession-errors" "$HOME/.xsession-errors.old" 
rm -f  "$HOME/.ICEauthority"
rm -fr "$HOME/.compose-cache"


 
  

 
