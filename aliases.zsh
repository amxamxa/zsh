#!/usr/bin/env zsh
###########################################
##  filename:    	aliases.zsh
##  filepath:     	/share/zsh
##  author:       	mxx
##  file status:	work in progress
##  comments: 	    - ^e edit
##  ---------------------------------------
#   n i x   o s :
#   -        zsh aliase
#   - global zsh aliase
#   - suffix zsh aliase	
#   HOWTO :
# -  Abhängigkeiten Pakets rekursiv an:  	nix-store -q --references --recursive
# - welche anderen Pakete von einem bestimmten Paket abhängen:  nix-store -q --referrers /nix/store/ .
#
# doppelte pkgs> sort packages.nix | uniq -d
# ODER> awk '{lines[$0] = lines[$0] ? lines[$0] "," NR : NR; count[$0]++}  \
#	END {for (line in count) if (count[line] > 1) print line " (" lines[line] ")"}' packages.nix
#----------------------------------------------------------


# 	  Globale Aliase (werden überall in der Zeile expandiert)
# 	  usage% file G 'pattern'

alias -g ED='gnome-text-editor --standalone --ignore-session'
alias -g gedit='gnome-text-editor --standalone --ignore-session'
alias -g CMD='command'
alias -g SRC='source'
alias -g L='| less'
alias -g LL='| less -X -j5 --tilde --save-marks \
    --incsearch --RAW-CONTROL-CHARS \
    --LINE-NUMBERS --line-num-width=3 \
    --quit-if-one-screen --use-color \
    --color=NWr --color=EwR --color=PbC --color=Swb'
alias -g G='| grep --ignore-case --color=auto'
alias -g HH='--help 2>&1 | grep'
alias -g H='--help || -h'
alias -g NN='2> /dev/null'
alias -g D0='2> /dev/null'
alias -g 00='&& echo "Success" || echo "Failed"'

# dahinter PKGS name, er letzte Pfad ist der vollständige Pfad zum gebauten Paket im Nix-Store. Ohne --no-out-link würde Nix einen Symlink namens result im aktuellen Verzeichnis erstellen, der auf diesen Pfad zeigt.
alias -g NN="nix-build --no-out-link '<nixpkgs>' -A"  

#   Suffix-Aliase (werden ausgeführt, wenn ein Dateiname als Befehl eingegeben wird)
### -----------------------------------------------------  ####
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm,opus,flac}='vlc'
# alias -s mp4='vlc --fullscreen --no-video-title-show --no-video-border'
alias -s {jpg,jpeg,png,bmp,svg,gif,webp}='kitty +kitten icat &'
alias -s {js,json,env,html,css,toml}='bat -p'
alias -s {conf}='micro -filetype bash'
alias -s {nix}='gnome-text-editor &'
alias -s html='firefox &'
alias -s py='python &'
alias -s log='ccze'
# Die folgende Definition überschreibt die vorherige für .md-Dateien.
alias -s {md}='marker --preview --display=:0 &'
alias -s {txt}='micro -filetype bash'
# "Run" ssh links to clone repos
# % git@github.com:stefanjudis/dotfiles.git # wird zu
# % git clone git@github.com:stefanjudis/dotfiles.git
# alias -s git="git clone"
###

alias -s {pdf,PDF}='open_pdf'


# --- Asciinema Aufnahmen ---
# !! IN aliases.nix: environment.interactiveShellInit → CHmod()
# CHmod() {
#     local dir="${1:-.}"
#         # Check if directory exists
#     if [[ ! -d "$dir" ]]; then
#         echo -e "\t${RED}Error: Directory '$dir' not found${RESET}"
#         return 1
#     fi
#     echo -e "\t${PINK}Setting u+x for *.py, *.sh, *.zsh scripts in ${dir}${RESET}"
#     find "$dir" -maxdepth 1 -type f \
#         \( -name "*.sh" -o -name "*.zsh" -o -name "*.py" \) \
#         -exec chmod -v u+x {} + 2>/dev/null
#     local exit_code=$?
#     [[ $exit_code -eq 0 ]] && echo -e "\t${GREEN}Done!${RESET}" \
#     || echo -e "\t${RED}No matching files found${RESET}"
# }
# !! IN aliases.nix: environment.interactiveShellInit → CHmod-()
# CHmod-() {
#     local dir="${1:-.}"  # Use current dir if no argument provided
#     # Check if directory exists
#     if [[ ! -d "$dir" ]]; then
#         echo -e "\t${RED}Error: Directory '$dir' not found${RESET}"
#         return 1
#     fi
#     echo -e "\t${PINK}u-x   *.py, *.sh, *.zsh scripts in ${dir} now NOT executable! ${RESET}"
#     find "$dir" -maxdepth 1 -type f \
#         \( -name "*.sh" -o -name "*.zsh" -o -name "*.py" \) \
#         -exec chmod -v u-x {} + 2>/dev/null
#     local exit_code=$?
#     [[ $exit_code -eq 0 ]] && echo -e "\t${GREEN}Done\!${RESET}" \
#     || echo -e "\t${YELLOW}No matching files found${RESET}"
# }
# neue Aufnahme am naechsten Tag, landet wieder im asciinema/-Unterordner, aber unter dem neuen Namen. Die alte Datei bleibt erhalten.
# !! IN aliases.nix: environment.interactiveShellInit → REC()
# REC() {
#   local title="$(basename "$(dirname "$(pwd)")")@$(date +%F)"
#   mkdir -p asciinema
#   echo -e "${PINK}asciinema rec --overwrite --idle-time-limit=1 --title=\"$title\"${RESET}"
#   asciinema rec --overwrite --idle-time-limit=1 --title="$title" "asciinema/$title.cast"
# }
# !! IN aliases.nix: environment.interactiveShellInit → PLAY()
# PLAY() {
#   local title="$(basename "$(dirname "$(pwd)")")@$(date +%F)"
#   echo -e "${PINK}asciinema play \"asciinema/$title.cast\"${RESET}"
#   asciinema play "asciinema/$title.cast"
# }

# GREP2aliases.zsh -- Funktion zum Suchen von WORD in ALIAS
# !! IN aliases.nix: environment.interactiveShellInit → g2ali()
# g2ali() {
#   if [[ -z "$1" ]]; then
#     echo -e "\t${RED}Fehler: Kein Suchbegriff angegeben.${RESET}\n"
#     echo -e "\t${PINK}Verwendung: g2ali <Suchbegriff>${RESET}"
#     return 1312
#   fi
#   # Suche in Aliases mit optionaler Syntaxhervorhebung durch `bat`
#   if command -v bat &>/dev/null; then
#     alias | grep -i --color=always "$1" | command bat -l toml
#     echo -e "\t${PINK} alias | grep -i --color=always "$1" | command bat -l toml ${RESET}\n"
#   else
#     alias | grep -i --color=always "$1"
#   fi
# }
#alias ali2g='g2ali'
#alias g2lol='g2ali'
#alias lol2g='g2ali'

# Funktion zum Suchen von WORD in ENV
# !! IN aliases.nix: environment.interactiveShellInit → g2env()
# g2env() {
#   if [[ -z "$1" ]]; then
#     echo -e "\t${RED}Fehler: Kein Suchbegriff angegeben.${RESET}"
#     echo -e "\t${PINK}Verwendung: g2env <Suchbegriff>${RESET}"
#     return 1312
#   fi
#   # Suche in Umgebungsvariablen mit optionaler Syntaxhervorhebung durch `bat`
#   if command -v bat &>/dev/null; then
#     printenv | grep -i --color=always "$1" | command bat -l toml
#     echo -e "\t${PINK} printenv | grep -i --color=always "$1" | command bat -l toml ${RESET}\n"
#   else
#     printenv | grep -i --color=always "$1"
#   fi
# }
#alias env2g='g2env'


#____________________________________________________________
#        du - estimate file space usage
# !! IN aliases.nix: environment.interactiveShellInit → D1()
# D1() {
#     local du_options="--human-readable --max-depth=1 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc'"
#     local current_dir
#     current_dir=$(pwd)
#     echo -e "\n\t${PINK}Zeigt 24 direkte Unterverzeichnisse, nach Größe sortiert an!"
#     echo -e "\n\t${GREEN}du ${du_options} ${current_dir} 2> /dev/null | sort -hr | head -n 24 ${PINK} \n... wir reden über Pfad ${NIGHT}${current_dir}${RESET}\n"
#     du $du_options "$current_dir" 2> /dev/null | sort -hr | head -n 24
#     echo -e "\n\t${GREEN}\t... und das Unterverzeichniss ist ${NIGHT}${current_dir}${GREEN}insgesamt:${RESET}"
#     du -sh 2> /dev/null
# }
# !! IN aliases.nix: environment.interactiveShellInit → D3()
# D3() {
#     local du_options="--human-readable --max-depth=3 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc'"
#     local current_dir
#     current_dir=$(pwd)
#     echo -e "\n\t${PINK}Zeigt 24 Unterverzeichnisse in 3ter Ebene, nach Größe sortiert an!"
#     echo -e "\t${GREEN}du ${du_options} ${current_dir} 2> /dev/null | sort -hr | head -n 24 ${PINK} \n... wir reden über Pfad${NIGHT}${current_dir}${RESET}\n"
#     du $du_options "$current_dir" 2> /dev/null | sort -hr | head -n 24
#     echo -e "\n\t${GREEN}\t... und das Unterverzeichniss ist ${NIGHT}${current_dir}${GREEN}insgesamt:${RESET}"
#     du -sh 2> /dev/null
# }


# !! IN aliases.nix: environment.interactiveShellInit → NIXinfo()
# NIXinfo() {
#   printf "%s\n" "${PINK} Info und BESCHREIBUNG ${RESET}"
#   nix-shell -p nix-info --run "nix-info -m"
# }

# --- NixOS spezifische Aliase ---
# !! IN aliases.nix: environment.shellAliases (mkIf lsd) → NIXpkgs
# alias NIXpkgs='echo -e "\t${PINK}Liste alle installierten Pakete im current-system Profil auf unter  ${NIGHT}  \'/run/current-system/sw/bin/' ${RESET}" && sleep 2 && lsd --oneline --classify --no-symlink /run/current-system/sw/bin/'
# um eine Liste aller installierten Pakete anzuzeigen
# SIEHE ERSATZ  home/bin/NIXenv
# alias NIXenv='echo -e "${PINK}nix-env --query --installed ${NIGHT}global verfügbare, mit "nix-env" installed nixOS Pakete OHNE die Versionsnummer (letzter Teil)${RESET} /n" && nix-env --query --installed | sed -E '\''s/-[0-9.]+$//'\'' | sort'
# !! IN aliases.nix: environment.interactiveShellInit → NIXconf()
# NIXconf() {
#   echo -e "\t${PINK}Öffne NixOS-Konfigurationsdateien in einem Editor${RESET}"
#   if [ -d /etc/nixos ]; then
#     if command -v gnome-text-editor &> /dev/null; then
#       gnome-text-editor --standalone --ignore-session --new-window "/etc/nixos/*.nix"
#     elif command -v micro &> /dev/null; then
#       micro /etc/nixos/*.nix
#     elif command -v nano &> /dev/null; then
#       nano /etc/nixos/*.nix
#     else
#       echo "Fehler: Keiner der Editoren (gnome-text-editor, micro, nano) ist installiert."
#     fi
#   else
#     echo "Fehler: Verzeichnis /etc/nixos existiert nicht."
#   fi
# }

# !! IN aliases.nix: environment.shellAliases (mkIf eza) → NIXboot
# alias NIXboot='echo -e "\t${PINK} shows boota-able config.nix w/ timestamp of creation${LILA}which can select by grub" && \
#     eza -U --header --long --tree --almost-all --group-directories-first /nix/var/nix/profiles/'

# !! IN aliases.nix: environment.shellAliases (mkIf eza) → NIXrun
# alias NIXrun='eza --tree --only-dirs /run/current-system/sw/share'

# --- Shell & System Konfiguration ---
# !! IN aliases.nix: environment.shellAliases → FARBE
# alias FARBE='echo -e "\t${PINK}Lade Farbskript${RESET}" && source_or_error "$ZDOTDIR/functions/colors.sh" || source "$ZDOTDIR/functions/colors.sh"'
# alias MAN='echo -e "\t${PINK}Suche Manpages mit Wildcard-Unterstützung${RESET}" && man --wildcard'

# !! IN aliases.nix: environment.shellAliases → RM
# alias RM='echo -e "\t${PINK}Lösche alle Backup-Dateien (*~) im aktuellen Verzeichnis${RESET}" && find . -type f -name "*~" -delete'


# --- Terminal Themes & Fonts ---
# !! IN aliases.nix: environment.shellAliases → COLsw
# alias COLsw='color-theme-switch && echo -e "${BROWN}color-theme-switch aus my-function.zsh${RESET}"'
# !! IN aliases.nix: environment.shellAliases → COL+
# alias COL+='theme.sh --dark -i2 >> color-theme.md && echo -e "${BROWN}theme.sh --dark -i2 >> color-theme.md ${RESET}"'
# !! IN aliases.nix: environment.shellAliases → COL256
# alias COL256='
#         for i in {0..255}; do
#          printf "\e[38;5;${i}mcolor%-5i\e[0m" "$i"
#                 if (( ($i + 1) % 8 == 0 )); then 
#                         echo 
#                 fi; 
#         done; 
#          echo -e "\n\tSYNTAX: 38;5;<colorXYZ>:
#          \tz.B.: 38;5;125 für Farbe aus obiger 256-Farben-Palette"'
# ALT: alias FC-list='echo -e "\t${PINK}Liste skalierbare Monospace-Schriftarten auf${RESET}" && fc-list : family spacing outline scalable | grep -e spacing=100 -e spacing=90 | grep -e outline=True | grep -e scalable=True | sort -u'
# !! IN aliases.nix: environment.shellAliases → FC-list
# alias FC-list='FClist.sh || $HOME/bin/FClist.sh'
 

## ZOXIDE
# !! IN aliases.nix: environment.shellAliases (mkIf zoxide) → za, zq, zqi, zr
# alias za='echo -e "\t${PINK}Füge aktuelles Verzeichnis zur zoxide-Datenbank hinzu${RESET}" && zoxide add'
# alias zq='echo -e "\t${PINK}Suche Verzeichnis in zoxide-Datenbank${RESET}" && zoxide query'
# alias zqi='echo -e "\t${PINK}Interaktive Suche in zoxide-Datenbank${RESET}" && zoxide query -i'
# alias zr='echo -e "\t${PINK}Entferne Verzeichnis aus zoxide-Datenbank${RESET}" && zoxide remove'


#	_____________________________________________zsh_______________
##      * * Z S H * *
##  .zshenv .zshrc aliases.zsh
alias Zcopy='nano "$ZDOTDIR/.zshrc" && source "$ZDOTDIR/.zshrc" && \
    echo -e "\n\t${PINK}source $ZDOTDIR/.zshrc erfolgreich!${RESET}\n" || \
    echo -e "\n\t${GELB}source $ZDOTDIR/.zshrc  ---NICHT---  erfolgreich!${RESET}\n"'

alias Zconf='gnome-text-editor -s "$ZDOTDIR/.zshrc" && source "$ZDOTDIR/.zshrc" && \
    echo -e "\n\t${PINK}source $ZDOTDIR/.zshrc ${RED}s erfolgreich!${RESET}\n" || \
    echo -e "\n\t${RED}source $ZDOTDIR/.zshrc   ---NICHT---  erfolgreich!${RESET}\n"'
alias ZRC='Zconf'
# alias ZENV='micro -filetype zsh $HOME/.zshenv" && source "$HOME/.zshenv" && echo -e "\n\t${PINK}source ~/.zshenv erfolgreich!${RESET}\n" || echo -e "\n\t${GELB}source ~/.zshenv ---NICHT---  erfolgreich!${RESET}\n"'
#alias ZEconf='ZENV'

alias ZALI='gnome-text-editor -s "$ZDOTDIR/aliases.zsh" && source "$ZDOTDIR/aliases.zsh" && \
    echo -e "\n\t${PINK}source $ZDOTDIR/aliases.zsh erfolgreich!${RESET}\n" || \
    echo -e "\n\t${GELB}source $ZDOTDIR/aliases.zsh   ---NICHT---  erfolgreich!${RESET}\n"'
alias Zali='ZALI'

alias Zfunc='micro "$ZDOTDIR/functions/my-functions.zsh" && source "$ZDOTDIR/functions/my-functions.zsh"'
alias Zcopy='echo -e "\n\t${PINK}Kopiere Zsh-Konfigurationsdateien ins Backup-Verzeichnis${RESET}" && \
    cp --verbose "$ZDOTDIR/.zshrc" "/share/bkp/zsh/$(date +'"'"'%F'"'"').nix.zshrc.zsh" && \
    cp --verbose "$HOME/.zshenv" "/share/bkp/zsh/$(date +'"'"'%F'"'"').nix.zshenv.zsh" && \
    cp --verbose "$ZDOTDIR/aliases.zsh" "/share/bkp/zsh/$(date +'"'"'%F'"'"')nix.aliases.zsh"'
alias Zopt='echo -e "\t${PINK}Wrapper für setopt${RESET}" && setopt'

#	_____________________________________________kitty______________
# !! IN aliases.nix: environment.shellAliases (mkIf kitty) → KITTYconf, Kconf
# alias KITTYconf='echo -e "\t${PINK}Öffne kitty  Konfigurationsdatei${RESET}" && \
#         gnome-text-editor --standalone --ignore-session  "$XDG_CONFIG_HOME/kitty/kitty.conf" || \
#         micro -filetype zsh "$KITTY_CONFIG_DIRECTORY/kitty.conf"'
# alias Kconf=KITTYconf
# !! IN aliases.nix: environment.shellAliases (mkIf kitty) → KITTYmap, Kmap, Kbind
# alias KITTYmap='echo -e "\t${PINK}Zeige alle Tastaturbelegungen (map) in der kitty.conf${RESET}" && bapNoComment "$KITTY_CONFIG_DIRECTORY/kitty.conf" || grep "map"'
# alias Kmap=KITTYmap
# alias Kbind=KITTYmap
#	____________________________________________________________________
# alias mango='echo -e "\t${PINK}Starte glxgears mit MangoHud Overlay${RESET}" && mangohud glxgears &'
# alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia-settings-rc"'
# alias mangconf='echo -e "\t${PINK}Öffne MangoHud Konfigurationsdatei${RESET}" && micro -filetype bash "$XDG_CONFIG_HOME/MangoHud/MangoHud.conf"'



# ____________________________________________________________________

#	______________________________________________________espeak-ng______________
#alias Vtime='echo -e "\t${PINK}Lass die aktuelle Zeit ansagen${RESET}" && \
 #   espeak-ng -v mb-de5 -s 135 -p 15 -g 10 -k 10 -b 1 "Es ist jetzt $(date "+%R"). Heute ist $(date "+%A")."' \
#alias Vdate='echo -e "\t${PINK}Lass das aktuelle Datum ansagen${RESET}" && \
  #  espeak-ng -v mb-de5 -s 135 -p 15 -g 10 -k 10 -b 1 "Heute ist $(date "+%A")! Wir haben den $(date "+%d")ten $(date "+%B"). Wir sind im Jahre $(date "+%Y") nach neuer Zeitrechnung."'

#	_________________________________________________________xwininfo___________
##     gnome gui windows ##

#	____________________________________________________________________

alias debug='echo "Debugging..."; set -x'

# _________cat / batcat____________________

# !! IN aliases.nix: environment.shellAliases (mkIf bat) → bap
# alias bap='bat -p'
# !! IN aliases.nix: environment.shellAliases (mkIf bat) → bat='bat6'
# alias bat='bat6'
# gute themes für batcat:       ansi, OneHalfDark, Dracula, Coldark-Dark

# !! IN aliases.nix: environment.shellAliases (mkIf bat) → bat6
# alias bat6='bat --wrap=auto --decorations=always --theme=gruvbox-dark'


#
#_____________________________________________________________________________

# !! IN aliases.nix: environment.shellAliases (mkIf eza) → e (different content, nix version takes precedence)
# alias e='echo -e "eza  ... pure" && \
#     eza --group-directories-first --git --width 76'
#alias lf='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} - Files only (hidden and non-hidden)files:${RESET}" && \
#    eza --grid --no-permissions --long \
#        --total-size --almost-all --no-time \
#        --color-scale age --color-scale-mode gradient \
#        --classify --header --only-files --width 76'
#alias ld='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} only (hidden and non-hidden)directorys:${RESET}\n" && \
#    eza --grid --no-permissions --long \
#        --total-size --almost-all --no-time \
#        --color-scale age --color-scale-mode gradient \
#        --classify --header --only-dirs --width 76'

#------------------------------------------------------------------  lsd
#alias l='echo -e "\t${PINK} LSD ohne alles ${RESET}\n" && lsd --classify --group-dirs=first 2> /dev/null'
#alias la='echo -e "\t${PINK} Zeigt alles in ${GELB}$(pwd)\n${PINK} (hidden) Files und (hidden)directory:${RESET}\n" && \
#    lsd --size short --human-readable \
#    	--group-dirs=first --almost-all \
#    	--classify 2> /dev/null'
#alias ll='echo -e "\t${PINK} LSD ${LILA} ... mit  alles  ${GELB}in $(pwd)\n${PINK}(mit relativer Zeit ohne Gruppenberechtigung): ${RESET}\t" && \
#    lsd --almost-all --size short --classify --group-dirs=first \
#        --date "relative" --no-symlink --hyperlink "always" --long \
#        --size short --header \
#        --blocks "size,links,name,user,date" 2> /dev/null'
#alias lll='echo -e "\t${PINK} LSD ${LILA}  ... mit  alles  ${GELB}in $(pwd)\n${PINK} (mit absoluter Zeit und Gruppenberechtigung): ${RESET}\t" && \
#    lsd --almost-all --total-size --date "+%d. %b %Y %H:%M Uhr" \
 #       --classify --group-dirs "first" --no-symlink --hyperlink "always" \
#        --long --size short --header \
#        --blocks "permission,size,links,name,user,group,date" 2> /dev/null'
#alias lt='echo -e "\t${PINK} LSD ${LILA}...mit alles ${GELB}in $(pwd)${PINK} --reverse --time-sort: ${RESET} \t" && \
 #   lsd --almost-all --total-size --group-dirs "first"  \
 #       --classify --no-symlink --hyperlink "always" \
 #       --long --size "short" --header --reverse \
 #       --blocks "size,links,name,date" --timesort 2> /dev/null'
        
#alias lx='echo -e "\t${PINK} LSD ${LILA}...mit  alles  ${GELB}in $(pwd)${PINK}--reverse --extension-sort: ${RESET}\t" && \
#    lsd --almost-all --size short --classify --group-dirs "first" \
#        --date "relative" --no-symlink --hyperlink "always" \
#       --long --size "short" --reverse --header \
#        --blocks "size,links,name,user,date"    --extensionsort 2> /dev/null'

# --- Klassische Werkzeuge ---
# !! IN aliases.nix: environment.shellAliases → ".."='cd ..'
# alias ..='cd ..'
# !! IN aliases.nix: environment.shellAliases (mkIf wget) → wget
# alias wget="wget -c"
# !! IN aliases.nix: environment.shellAliases (mkIf btop) → top
# alias top="btop"
# !! IN aliases.nix: environment.shellAliases (mkIf duf) → df
# alias df='echo -e "\t${PINK} duf{RESET}\n" && duf'
# !! IN aliases.nix: environment.shellAliases → EIN, Reboot, AUS
# alias EIN="shutdown -r now"
# alias Reboot="shutdown -r now"
# alias AUS="shutdown now"

#alias AUS="sudo nala update && sudo shutdown now"



#mcd () {
#	echo -e "\t${PINK} Verzeichnis${GREEN} $1 ist angelegt!${RESET}\n"
#    mkdir -p "$1"
#    cd "$1"
#}

# --- Tipfehler & Shortcuts ---


#	________________________________________________________________________________
alias GIT='echo -e "\t${PINK}git aliase aus Zeile 444 bis 500\t $ZDOTDIR/aliases.zsh  ${RESET}\n" && \
    bat --wrap=auto --decorations=always \
        --theme=Coldark-Dark --line-range=444:500 "$ZDOTDIR/aliases.zsh"'
#__________font: univers_______________________
#	              88
#	              ""    ,d
#	                    88
#	  ,adPPYb,d8  88  MM88MMM
#	 a8"    `Y88  88    88
#	 8b       88  88    88
#	 "8a,   ,d88  88    88,
#	  `"YbbdP"Y8  88    "Y888
#	  aa,    ,88
#	   "Y8bbdP"
#	--------------------------------------

# --- Git Konfiguration ---
#alias gitgit='echo -e "\t${PINK}Setze globale Git-Konfiguration und zeige sie an${RESET}" && \
#    git config -f $GIT_CONFIG user.email "max.kempter@gmail.com" && \
#    git config -f $GIT_CONFIG user.name "amxamxa" && \
#    git config -l | bat3 -l "sh"'
#alias gitloc='echo -e "\t${PINK}Setze lokale Git-Konfiguration (~/.gitlocal) und zeige sie an${RESET}" && \
#    git config -f ~/.gitlocal user.email "max.kempter@gmail.com" && \
#    git config -f ~/.gitlocal user.name "amxamxa" && \
#    git config -l | bat3 -l "sh"'
# Git Status
# !! IN aliases.nix: environment.shellAliases (mkIf git) → gsss
# alias gsss='echo -e "${PINK}\n\t git status --short ${RESET} with abbr.:${RESET}\n${GELB}?? ... Untracked files${RESET}\t${GELB}U ... Files with merge conflicts${RESET}\t ${GELB}A ... New files added to staging ${RESET}\t${GELB}M ... Modified files${RESET}\t${GELB}D ... Deleted files${RESET}\t${GELB}R ... Renamed files${RESET}\t${GELB}C ... Copied files${RESET}\n" && git status -s'
# !! IN aliases.nix: environment.shellAliases (mkIf git) → gss()
# gss() {
#     cowsay -nW 60 "$(echo -e "${NIGHT}[Git Status]${RESET}\n$(git status -s)")"
#     echo -e "\n${PINK}Legende:${RASP}
#    M: Modified |  A: Staged
#    D: Deleted  |  R: Renamed
#    C: Copied   |  ?: Untracked${RESET}"
# }
# Git Add
# !! IN aliases.nix: environment.shellAliases (mkIf git) → ga
# alias ga='echo -e "${GELB}\nFügt Änderungen im Arbeitsverzeichnis zum Staging-Bereich hinzu${RESET}\n" && git add'
# Git Push
# !! IN aliases.nix: environment.shellAliases (mkIf git) → gp
# alias gp='echo -e "${GELB}\nPushed lokale Änderungen auf den Remote-Branch${RESET}\n" && git push'
# alias gpo='echo -e "${GELBninjas2}\nPushed lokale Änderungen auf den Remote-Branch \"origin\"${RESET}\n" && git push origin'
# alias gpof='echo -e "${GELB}\nForce-Pushed lokale Änderungen auf den Remote-Branch \"origin\" mit Lease-Check${RESET}\n" && git push origin --force-with-lease'
# alias gpofn='echo -e "${GELB}\nForce-Pushed lokale Änderungen auf den Remote-Branch \"origin\" mit Lease-Check und ohne Verifizierung${RESET}\n" && git push origin --force-with-lease --no-verify'
# alias gpt='echo -e "${GELB}\nPushed alle Tags auf den Remote-Branch${RESET}\n" && git push --tag'
# Git Tag
# alias gtd='echo -e "${GELB}\nLöscht einen lokalen Tag${RESET}\n" && git tag --delete'
# alias gtdr='echo -e "${GELB}\nLöscht einen Remote-Tag${RESET}\n" && git tag --delete origin'
# Git Branch
# !! IN aliases.nix: environment.shellAliases (mkIf git) → grb
# alias grb='echo -e "${GELB}\nZeigt die Remote-Branches an${RESET}\n" && git branch -r'
# !! IN aliases.nix: environment.shellAliases (mkIf git) → gb
# alias gb='echo -e "${GELB}\nZeigt alle Branches im aktuellen Repository an${RESET}\n" && git branch'
# Git Pull
# Git Commit

# !! IN aliases.nix: environment.shellAliases (mkIf git) → glol
# alias glol='echo -e "${GELB}\nZeigt die Commit-Historie in einer graphischen Darstellung an${RESET}\n" && git log --graph --abbrev-commit --oneline --decorate'
# Git Remote
# !! IN aliases.nix: environment.shellAliases (mkIf git) → gr
# alias gr='echo -e "${GELB}\nZeigt die Namen der Remote-Repositories an${RESET}\n" && git remote'
# !! IN aliases.nix: environment.shellAliases (mkIf git) → grs
# alias grs='echo -e "${GELB}\nZeigt Informationen zu den Remote-Repositories an${RESET}\n" && git remote show'
# !! IN aliases.nix: environment.shellAliases (mkIf git) → gblog
# alias gblog="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:red)%(refname:short)%(color:reset) - %(color:yellow)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:blue)%(committerdate:relative)%(color:reset))'"
#	_______GIT - AUSGABE ENDE___________________________________________


