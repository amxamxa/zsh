#!/usr/bin/env zsh
###########################################
##  filename:    	aliases.zsh
##  filepath:     	/share/zsh
##  author:       	mxx
##  file save date: 04.12.23
##  file creation: 	23 oct
##  file status:	work in progress
##  comments: 	    - ^e edit
###########################################
 
#   n i x   o s :
#			 -        zsh aliase
#			 - global zsh aliase
#			 - suffix zsh aliase
#	______________________________________________________nix_OS___
# 		HOWTO :
# alle Abhängigkeiten eines Pakets rekursiv an:
# 		nix-store -q --references --recursive
# Finde heraus, welche anderen Pakete von einem bestimmten Paket abhängen:
#	nix-store -q --referrers /nix/store/ .
# Finde doppelte pkgs.?
# 	sort /etc/nixos/packages.nix | uniq -d
# 				ODER
#	awk '{lines[$0] = lines[$0] ? lines[$0] "," NR : NR; count[$0]++}  \
#	END {for (line in count) if (count[line] > 1) print line " (" lines[line] ")"}' packages.nix
##  ZSH DIRECTORY STACK - DS
   alias -g D='dirs -v'

alias tuxpaint='tuxpaint --datadir $HOME/bilder/TUXPAINT/data --exportdir $HOME/bilder/TUXPAINT/export --savedir $HOME/bilder/TUXPAINT/saves'
# --- Allgemeine Werkzeuge ---
alias fd='echo -e "\t${PINK}Führe fd (find alternative) mit automatischer Farbgebung aus${RESET}" && fd --color=auto'
alias DU='echo -e "\t${PINK}Starte interaktiven Disk-Usage-Analyzer (ncdu)${RESET}" && ncdu --color dark'
alias ncdu='echo -e "\t${PINK}Starte interaktiven Disk-Usage-Analyzer (ncdu) mit dunklem Farbschema${RESET}" && ncdu --color dark'
alias cp='echo -e "\t${PINK}Kopiere Dateien/Verzeichnisse mit xcp (verbose)${RESET}" && xcp --verbose'

# --- Asciinema Aufnahmen ---
# TODO  SIND NUN IN Zfunc
# neue Aufnahme am naechsten Tag, landet wieder im asciinema/-Unterordner, aber unter dem neuen Namen. Die alte Datei bleibt erhalten.
REC() {
  local title="$(basename "$(dirname "$(pwd)")")@$(date +%F)"
  mkdir -p asciinema
  echo -e "${PINK}asciinema rec --overwrite --idle-time-limit=1 --title=\"$title\"${RESET}"
  asciinema rec --overwrite --idle-time-limit=1 --title="$title" "asciinema/$title.cast"
}
PLAY() {
  local title="$(basename "$(dirname "$(pwd)")")@$(date +%F)"
  echo -e "${PINK}asciinema play \"asciinema/$title.cast\"${RESET}"
  asciinema play "asciinema/$title.cast"
}

# GREP2aliases.zsh -- Funktion zum Suchen von WORD in ALIAS
g2ali() {
  if [[ -z "$1" ]]; then
    echo -e "\t${RED}Fehler: Kein Suchbegriff angegeben.${RESET}\n"
    echo -e "\t${PINK}Verwendung: g2ali <Suchbegriff>${RESET}"
    return 1312
  fi
  # Suche in Aliases mit optionaler Syntaxhervorhebung durch `bat`
  if command -v bat &>/dev/null; then
    alias | grep -i --color=always "$1" | command bat -l toml
    echo -e "\t${PINK} alias | grep -i --color=always "$1" | command bat -l toml ${RESET}\n"
  else
    alias | grep -i --color=always "$1"
  fi
}
alias ali2g='g2ali'
alias g2lol='g2ali'
alias lol2g='g2ali'

# Funktion zum Suchen von WORD in ENV
g2env() {
  if [[ -z "$1" ]]; then
    echo -e "\t${RED}Fehler: Kein Suchbegriff angegeben.${RESET}"
    echo -e "\t${PINK}Verwendung: g2env <Suchbegriff>${RESET}"
    return 1312
  fi
  # Suche in Umgebungsvariablen mit optionaler Syntaxhervorhebung durch `bat`
  if command -v bat &>/dev/null; then
    printenv | grep -i --color=always "$1" | command bat -l toml
    echo -e "\t${PINK} printenv | grep -i --color=always "$1" | command bat -l toml ${RESET}\n"
  else
    printenv | grep -i --color=always "$1"
  fi
}
alias env2g='g2env'


#____________________________________________________________
#        du - estimate file space usage
D1() {
    local du_options="--human-readable --max-depth=1 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc'"
    local current_dir
    current_dir=$(pwd)
    echo -e "\n\t${PINK}Zeigt 24 direkte Unterverzeichnisse, nach Größe sortiert an!"
    echo -e "\n\t${GREEN}du ${du_options} ${current_dir} 2> /dev/null | sort -hr | head -n 24 ${PINK} \n... wir reden über Pfad ${NIGHT}${current_dir}${RESET}\n"
    du $du_options "$current_dir" 2> /dev/null | sort -hr | head -n 24
    echo -e "\n\t${GREEN}\t... und das Unterverzeichniss ist ${NIGHT}${current_dir}${GREEN}insgesamt:${RESET}"
    du -sh 2> /dev/null
}
D3() {
    local du_options="--human-readable --max-depth=3 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc'"
    local current_dir
    current_dir=$(pwd)
    echo -e "\n\t${PINK}Zeigt 24 Unterverzeichnisse in 3ter Ebene, nach Größe sortiert an!"
    echo -e "\t${GREEN}du ${du_options} ${current_dir} 2> /dev/null | sort -hr | head -n 24 ${PINK} \n... wir reden über Pfad${NIGHT}${current_dir}${RESET}\n"
    du $du_options "$current_dir" 2> /dev/null | sort -hr | head -n 24
    echo -e "\n\t${GREEN}\t... und das Unterverzeichniss ist ${NIGHT}${current_dir}${GREEN}insgesamt:${RESET}"
    du -sh 2> /dev/null
}


NIXinfo() {
  printf "%s\n" "${PINK} Info und BESCHREIBUNG ${RESET}"
  nix-shell -p nix-info --run "nix-info -m"
}

# --- NixOS spezifische Aliase ---
alias NIXpkgs='echo -e "\t${PINK}Liste alle installierten Pakete im current-system Profil auf unter  ${NIGHT}  \\'/run/current-system/sw/bin/' ${RESET}" && sleep 2 && lsd --oneline --classify --no-symlink /run/current-system/sw/bin/'
# um eine Liste aller installierten Pakete anzuzeigen
# SIEHE ERSATZ  home/bin/NIXenv
# alias NIXenv='echo -e "${PINK}nix-env --query --installed ${NIGHT}global verfügbare, mit "nix-env" installed nixOS Pakete OHNE die Versionsnummer (letzter Teil)${RESET} /n" && nix-env --query --installed | sed -E '\''s/-[0-9.]+$//'\'' | sort'
NIXconf() {
  echo -e "\t${PINK}Öffne NixOS-Konfigurationsdateien in einem Editor${RESET}"
  if [ -d /etc/nixos ]; then
    if command -v gnome-text-editor &> /dev/null; then
      gnome-text-editor --standalone --ignore-session --new-window "/etc/nixos/*.nix"
    elif command -v micro &> /dev/null; then
      micro /etc/nixos/*.nix
    elif command -v nano &> /dev/null; then
      nano /etc/nixos/*.nix
    else
      echo "Fehler: Keiner der Editoren (gnome-text-editor, micro, nano) ist installiert."
    fi
  else
    echo "Fehler: Verzeichnis /etc/nixos existiert nicht."
  fi
}
alias Nconf=NIXconf

alias NIXupdate='echo -e "\t${PINK}Führe nixos-rebuild switch aus...${RESET}" && \
    sudo nixos-rebuild switch --show-trace --verbose | \
    cowsay "UPDATE: nixos-rebuild switch ist jetzt fertig" | \
    xcowthink --image="$HOME/bilder/nixOS-logo.png" --time=3 --at=1200,200 --left "UPDATE: nixos-rebuild switch ist jetzt fertig"'
alias Nupt=NIXupdate

alias NIXupgrade='echo -e "\t${PINK}Führe nixos-rebuild switch --upgrade aus...${RESET}" && \
    sudo nixos-rebuild switch --upgrade --show-trace -v && \
    xcowthink --image="$HOME/bilder/nixOS-logo.png" --time=10 --at=1200,200 --monitor=0 --left --font=unifont "UPGRADE: nixos-rebuild switch ist jetzt fertig"'
alias Nupg=NIXupgrade

alias NIXboot='echo -e "\t${PINK} shows boota-able config.nix w/ timestamp of creation${LILA}which can select by grub" && \
    eza -U --header --long --tree --almost-all --group-directories-first /nix/var/nix/profiles/'
# alias NIXcurrentCopy='echo -e "\t${PINK}cp  /run/current-system/configuration.nix ${LILA}to /share/nixos/current-system-bkp${RESET}" && cp -fv /run/current-system/configuration.nix /share/nixos/current-system-bkp/$(date +%F)-conf.nix'
# alias NcurrCopy= NIXcurrentCopy

alias NIXoi='echo -e "\t${NIGHT}sudo nixos-rebuild switch --profile-name xam4boom --upgrade${PINK}" && sudo nixos-rebuild switch --show-trace --upgrade --profile-name "xam4boom" -I nixos-config=/etc/nixos/configuration.nix && echo -e "__________end ${RESET}"'
alias Nboom='echo -e "\t${NIGHT}sudo nixos-rebuild switch --profile-name audio --upgrade${PINK}" && sudo nixos-rebuild switch --show-trace --upgrade --profile-name "audio" -I nixos-config=/etc/nixos/configuration.nix && echo -e "__________end ${RESET}"'
alias Nixboom=NIXoi # Alias für NIXoi
alias Ncopy=NIXcopy # Verweist auf ein nicht definiertes NIXcopy

alias NIXref='echo -e "\t${PINK}Zeige die direkten Abhängigkeiten eines Nix-Store-Pfades an${RESET}" && nix-store -q --references /nix/store/'

# alias NIXempty ='echo "Müll wird entleert!" &&  echo -e "{PINK}  lol" && sudo rm -v /nix/var/nix/gcroots/auto/* &&  sudo nix-collect-garbage -d && 	sudo nix-store --optimise -vvv'

# --- Shell & System Konfiguration ---
alias FARBE='echo -e "\t${PINK}Lade Farbskript${RESET}" && source_or_error "$ZDOTDIR/functions/colors.sh" || source "$ZDOTDIR/functions/colors.sh"'
alias MAN='echo -e "\t${PINK}Suche Manpages mit Wildcard-Unterstützung${RESET}" && man --wildcard'

alias RM='echo -e "\t${PINK}Lösche alle Backup-Dateien (*~) im aktuellen Verzeichnis${RESET}" && find . -type f -name "*~" -delete'

# --- Git Konfiguration ---
alias gitgit='echo -e "\t${PINK}Setze globale Git-Konfiguration und zeige sie an${RESET}" && \
    git config -f $GIT_CONFIG user.email "max.kempter@gmail.com" && \
    git config -f $GIT_CONFIG user.name "amxamxa" && \
    git config -l | bat3 -l "sh"'
alias gitloc='echo -e "\t${PINK}Setze lokale Git-Konfiguration (~/.gitlocal) und zeige sie an${RESET}" && \
    git config -f ~/.gitlocal user.email "max.kempter@gmail.com" && \
    git config -f ~/.gitlocal user.name "amxamxa" && \
    git config -l | bat3 -l "sh"'

# --- Terminal Themes & Fonts ---
alias COLsw='color-theme-switch && echo -e "${BROWN}color-theme-switch aus my-function.zsh${RESET}"'
alias COL+='theme.sh --dark -i2 >> color-theme.md && echo -e "${BROWN}theme.sh --dark -i2 >> color-theme.md ${RESET}"'
# ALT: alias FC-list='echo -e "\t${PINK}Liste skalierbare Monospace-Schriftarten auf${RESET}" && fc-list : family spacing outline scalable | grep -e spacing=100 -e spacing=90 | grep -e outline=True | grep -e scalable=True | sort -u'
 alias FC-list='FClist.sh || $HOME/bin/FClist.sh'
 

## ZOXIDE
alias za='echo -e "\t${PINK}Füge aktuelles Verzeichnis zur zoxide-Datenbank hinzu${RESET}" && zoxide add'
alias zq='echo -e "\t${PINK}Suche Verzeichnis in zoxide-Datenbank${RESET}" && zoxide query'
alias zqi='echo -e "\t${PINK}Interaktive Suche in zoxide-Datenbank${RESET}" && zoxide query -i'
alias zr='echo -e "\t${PINK}Entferne Verzeichnis aus zoxide-Datenbank${RESET}" && zoxide remove'


#	_____________________________________________________zsh_______________
##      * * Z S H * *
##  .zshenv .zshrc aliases.zsh
alias Zcopy='nano "$ZDOTDIR/.zshrc" && source "$ZDOTDIR/.zshrc" && \
    echo -e "\n\t${PINK}source $ZDOTDIR/.zshrc erfolgreich!${RESET}\n" || \
    echo -e "\n\t${GELB}source $ZDOTDIR/.zshrc  ---NICHT---  erfolgreich!${RESET}\n"'
alias Zconf='ZRC'

# alias ZENV='micro -filetype zsh $HOME/.zshenv" && source "$HOME/.zshenv" && echo -e "\n\t${PINK}source ~/.zshenv erfolgreich!${RESET}\n" || echo -e "\n\t${GELB}source ~/.zshenv ---NICHT---  erfolgreich!${RESET}\n"'
alias ZEconf='ZENV'

alias ZALI='gnome-text-editor -s "$ZDOTDIR/aliases.zsh" && source "$ZDOTDIR/aliases.zsh" && \
    echo -e "\n\t${PINK}source $ZDOTDIR/aliases.zsh erfolgreich!${RESET}\n" || \
    echo -e "\n\t${GELB}source $ZDOTDIR/aliases.zsh   ---NICHT---  erfolgreich!${RESET}\n"'
alias Zali='ZALI'

alias Zfunc='micro "$ZDOTDIR/functions/my-functions.zsh" && source "$ZDOTDIR/functions/my-functions.zsh"'alias mangconf='echo -e "\t${PINK}Öffne MangoHud Konfigurationsdatei${RESET}" && micro -filetype bash "$XDG_CONFIG_HOME/MangoHud/MangoHud.conf"'
alias mango='echo -e "\t${PINK}Starte glxgears mit MangoHud Overlay${RESET}" && mangohud glxgears &'
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia-settings-rc"'
alias Zcopy='echo -e "\n\t${PINK}Kopiere Zsh-Konfigurationsdateien ins Backup-Verzeichnis${RESET}" && \
    cp --verbose "$ZDOTDIR/.zshrc" "/share/bkp/zsh/$(date +'%F').nix.zshrc.zsh" && \
    cp --verbose "$HOME/.zshenv" "/share/bkp/zsh/$(date +'%F').nix.zshenv.zsh" && \
    cp --verbose "$ZDOTDIR/aliases.zsh" "/share/bkp/zsh/$(date +'%F')nix.aliases.zsh"'
alias Zopt='echo -e "\t${PINK}Wrapper für setopt${RESET}" && setopt'

#	_____________________________________________kitty_______________________
alias KITTYconf='echo -e "\t${PINK}Öffne kitty Konfigurationsdatei${RESET}" &&  gnome-text-editor --standalone --ignore-session "$XDG_CONFIG_HOME/kitty/kitty.conf" | micro -filetype zsh "$KITTY_CONFIG_DIRECTORY/kitty.conf"'
alias Kconf=KITTYconf
alias KITTYmap='echo -e "\t${PINK}Zeige alle Tastaturbelegungen (map) in der kitty.conf${RESET}" && bap-NoComment "$KITTY_CONFIG_DIRECTORY/kitty.conf" | grep "map"'
alias Kmap=KITTYmap
alias Kbind=KITTYmap
#	____________________________________________________________________
# alias mdtohtml='pandoc $1 -s --to html --css=$HOME/.templates/cyberpunk-DM.css | w3m -T text/html'alias mangconf='echo -e "\t${PINK}Öffne MangoHud Konfigurationsdatei${RESET}" && micro -filetype bash "$XDG_CONFIG_HOME/MangoHud/MangoHud.conf"'
alias mango='echo -e "\t${PINK}Starte glxgears mit MangoHud Overlay${RESET}" && mangohud glxgears &'
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia-settings-rc"'
# alias mdtopdf='pandoc $1 -o ${1%.md}.pdf --template=$HOME/.templates/MDtoPDF.tex'

# --- Diverse Werkzeuge & Helfer ---
alias COL='terminal-colors -n && echo -e "${GREEN}\n...für Hex-Codes der Farben:${RED}%${LILA} terminal-colors -l ${RESET}\n"'
alias Col='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\''\n'\'';}; done'

alias untar='echo -e "\t${PINK}Entpacke .tar.bz2-Archive${RESET}" && tar -xvjf'
alias hack='echo -e "\t${PINK}Starte Hackertyper${RESET}" && hackertyper'

#	_______________________________neofetch_______________________________
alias neo='echo -e "\t${PINK} neofetch w/ ${LILA} \t $ZDOTDIR/neofetch/spaceinv.conf\t${RESET}" && neofetch --config "$ZDOTDIR/neofetch/spaceinv.conf"'
alias neo0='neo'
alias neo1='echo -e "\t  ${PINK}neofetch w/ ${LILA} \t 	$ZDOTDIR/neofetch/neofetch-short.conf\t${RESET}" && neofetch --config "$ZDOTDIR/neofetch/neofetch-short.conf"'
alias neo2='echo -e "\t${PINK} neofetch w/ ${LILA} \t	$ZDOTDIR/neofetch/config2.conf\t${RESET}" && neofetch --config "$ZDOTDIR/neofetch/config2.conf"'
alias neo3='echo -e "\t${LIME}   -  󱚡  --   --  🙼 🙼 🙼      󱢇     🙽 🙽 🙽   --    --  󱚡  --    -" && echo -e "\t${PINK}  neofetch w/ ${LILA} \t	$ZDOTDIR/neofetch/neofetch-long.conf\t${RESET}" && echo -e "\t${CYAN}   -  󱚡  --   --  🙼 🙼 🙼   󱢇     󱢇  🙽 🙽 🙽   --    --  󱚡  --    -" &&  neofetch --config "$ZDOTDIR/neofetch/neofetch-long.conf"'
alias neo4='echo -e "\t${PINK} neofetch w/ ${LILA} \t  a for loop of themes	/home/project/neofetch-themes${RESET}" && bash -c /home/project/neofetch-themes/for-loop.sh'

# ____________________________________________________________________
alias diff='echo -e "\t${GREEN} colordiff mit erweiterten Ignore-Optionen${RESET}" && \
    colordiff --ignore-case --ignore-tab-expansion \
      --ignore-trailing-space --ignore-space-change \
      --ignore-all-space --ignore-blank-lines'

alias LSblk='echo -e "\t${GREEN}enhanced lsblk .. als Tabelle mit --merge --zoned --ascii --topology ${RESET}" && \
    lsblk --width 80 --merge --zoned --ascii --topology \
          --output MODEL,MOUNTPOINTS,PATH,SIZE,TRAN,LABEL,FSTYPE,TYPE'

alias LSmod='echo -e "\t${GREEN}enhanced ls mod w/ Kernel-Modul -Name and -description ${RESET}" &&   while IFS= read -r name; do printf "%s\t\t%s\n" "${name}" "$(sudo modinfo "$name" | grep "description" | cut -c17-)"; done <<< "$(lsmod | cut -d " " -f1 | tail -n +2)"'

#	____________________________________________________________________
alias Mconf='echo -e "\t${PINK}Öffne micro Editor Konfiguration${RESET}" && micro "$MICRO_CONFIG_HOME/settings.json"'
alias Mbind='echo -e "\t${PINK}Öffne micro Editor Tastenbelegungen${RESET}" && micro "$MICRO_CONFIG_HOME/bindings.json"'

#	____________________________________________________________________
alias TREE2='echo -e "\t${GREEN}cmd tree --level 2"  && tree -L 2 -s -h -F -C -a --du --prune $(pwd)'
alias TREE4='echo -e "\t${GREEN}cmd tree --level 4 " && tree -L 4 -s -h -F -C -a --du --prune $(pwd)'
alias TREE8='echo -e "\t${GREEN}cmd tree --level 8"  && tree -L 8 -s -h -F -C -a --du --prune $(pwd)'

#	______________________________________________________espeak-ng______________
alias Vtime='echo -e "\t${PINK}Lass die aktuelle Zeit ansagen${RESET}" && \
    espeak-ng -v mb-de5 -s 135 -p 15 -g 10 -k 10 -b 1 "Es ist jetzt $(date "+%R"). Heute ist $(date "+%A")."'
alias Vdate='echo -e "\t${PINK}Lass das aktuelle Datum ansagen${RESET}" && \
    espeak-ng -v mb-de5 -s 135 -p 15 -g 10 -k 10 -b 1 "Heute ist $(date "+%A")! Wir haben den $(date "+%d")ten $(date "+%B"). Wir sind im Jahre $(date "+%Y") nach neuer Zeitrechnung."'

#	_________________________________________________________xwininfo___________
##     gnome gui windows ##
alias WMinfo='echo -e "\n\t${PINK}...2xklicken! mittels${GELB} cmd xprop und xwininfo${PINK}, zeigt Parameter des Windows an!${RESET}\n" && \
    xprop | grep --color=auto -E WM_CLASS && \
    xwininfo | grep --color=auto geometry'
alias WMverbose='echo -e "\n\t${PINK}\n 2xklicken! mittels${GELB} cmd xprop und xwininfo${PINK}... zeigt Parameter des Windows an!${RESET}\n" && \
    xprop | grep --color=auto -e "WM_CLASS(STRING)" -e "*SIZE*" -e "WM_PROTOCOLS(ATOM):" -e "geometry" -e "_NET_WM_ALLOWED_ACTIONS(ATOM)" && \
    xwininfo | grep --color=auto geometry'

#	____________________________________________________________________
alias Find='echo -e "
	${PINK} for   empty files\t $ fd --type empty --type file
	${LILA}       same as	\t\t$ fd  -te -tf
	${PINK} for   empty directories: $ fd --type empty --type directory  
	${LILA}       same same    $ fd  -te  -Td"  \n  \
	&& fd'
alias nano='echo -e "\t${PINK}Verwende micro anstelle von nano${RESET}" && micro || nano'
alias edit='echo -e "\t${PINK}Verwende micro als Standard-Editor${RESET}" && micro'
alias DATE='echo -e "\t${PINK}Zeige das aktuelle Datum  $(date "+%A, %-d. %B %Y"):{$RESET}" && echo -e "${GELB} $(date "+%A, %-d. %B %Y")${RESET} \n "&& echo -e "${PINK} oder $ (date +%F_%H-%M)\t ${RESET}" 	&& echo -e "${GELB} $(date "+%F_%H-%M") ${RESET}"'
alias CHmod='echo -e "\t${PINK}Mache alle .py, .sh und .zsh Skripte im aktuellen Verzeichnis ausführbar${RESET}" && find . -maxdepth 1 -type f \( -name "*.sh" -o -name "*.zsh"  -o -name "*.py" \) -exec chmod --verbose u+x {} +'
alias debug='echo "Debugging..."; set -x'


alias h='history'
alias history='history -t "%H:%MUhr am %d.%b: "'
alias g2history='cat "$HISTFILE" | grep -i --colour=always'
alias g2h=g2history
alias h2g=g2history

#	________________________________________________cat / batcat____________________
alias BATconf='echo -e "\t${PINK}Öffne bat Konfigurationsdatei${RESET}" && edit /share/bat/config.toml'
alias Bconf='BATconf'
alias bap='bat -p'
alias bat='bat6'
# gute themes für batcat:       ansi, OneHalfDark, Dracula, Coldark-Dark
alias bat1='bat --wrap=auto --plain --terminal-width 76 --theme=ansi'
alias bat2='bat --wrap=auto --plain --terminal-width 80 --theme=Dracula'
alias bat3='bat --wrap=auto --decorations=always --theme=Coldark-Dark'
alias bat4='bat --wrap=auto --number --decorations=always --theme=OneHalfDark'
alias bat5='bat --wrap=never --number --decorations=always --theme=base16'
alias bat6='bat --wrap=auto --decorations=always --theme=gruvbox-dark'


#
#_____________________________________________________________________________
#       e x a / e z a .. ls  ll  lh  ld ...
alias eweb='echo -e "\t${PINK}eza-Ansicht für Web-Projekte (z.B. Hugo)${RESET}" && eza --no-git --total-size --git-ignore -A -tree'
alias e-hugo='eweb'

alias lp='echo -e "\t${PINK}eza-Auflistung mit Fokus auf Git-Status${RESET}" && eza --octal-permissions --git -Al --git-repos --no-permissions --time-style=relative --group-directories-first --smart-group'
alias ep=lp

alias e1='echo -e "\t${GELB} eza --tree -level 1 ${RESET}\n" && \
    eza --all --long --group-directories-first \
        --color-scale --no-time --octal-permissions --width 76 \
        --tree --level 1 --color-scale-mode gradient'
alias e2='echo -e "\t${GELB} eza --tree -level 2${RESET}\n" && \
    eza --all --long --group-directories-first \
        --color-scale --no-time --octal-permissions --width 76 \
        --tree --level 2  --color-scale-mode gradient'
alias e3='echo -e "\t${GELB} eza --tree -level 3  ${RESET}\n" && \
    eza --all --long --group-directories-first \
        --color-scale --no-time --octal-permissions --width 76 \
        --tree --level 3 --color-scale-mode gradient'
alias e4='echo -e "\t${GELB} eza --tree -level 4 --git ${RESET}\n" && \
    eza --all --long --group-directories-first \
        --no-time --octal-permissions --width 76 \
        --color-scale age --color-scale-mode gradient \
        --tree --level 4 --git --color-scale-mode gradient'
alias eee='echo -e "\t${GELB} eza --tree -level 99 --git ${RESET}\n" && \
    eza --all --long --group-directories-first \
        --colour-scale all --color-scale-mode gradient --no-time \
        --octal-permissions --tree --level 99 --git --width 76'
alias ee='echo -e "eza  ... läuft"  && \
    eza --git --almost-all --long --group-directories-first \
        --colour-scale all --color-scale-mode gradient --octal-permissions'
alias e='echo -e "eza  ... pure" && \
    eza --group-directories-first --git --width 76'
alias lf='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} - Files only (hidden and non-hidden)files:${RESET}" && \
    eza --grid --no-permissions --long \
        --total-size --almost-all --no-time \
        --color-scale age --color-scale-mode gradient \
        --classify --header --only-files --width 76'
alias ld='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} only (hidden and non-hidden)directorys:${RESET}\n" && \
    eza --grid --no-permissions --long \
        --total-size --almost-all --no-time \
        --color-scale age --color-scale-mode gradient \
        --classify --header --only-dirs --width 76'

#------------------------------------------------------------------  lsd
alias l='echo -e "\t${PINK} LSD ohne alles ${RESET}\n" && lsd --classify --group-dirs=first 2> /dev/null'
alias la='echo -e "\t${PINK} Zeigt alles in ${GELB}$(pwd)\n${PINK} (hidden) Files und (hidden)directory:${RESET}\n" && \
    lsd --size short --human-readable --group-dirs=none --almost-all --classify2 > /dev/null'
alias ll='echo -e "\t${PINK} LSD ${LILA} REVERSE ... mit  alles  ${GELB}in $(pwd)\n${PINK}(mit relativer Zeit ohne Gruppenberechtigung): ${RESET}\t" && \
    lsd --almost-all --total-size --classify --group-dirs=first \
        --date "relative" --no-symlink --hyperlink "always" --long \
        --size short --header \
        --blocks "size,links,name,user,date" 2> /dev/null'
alias lll='echo -e "\t${PINK} LSD ${LILA}  ... mit  alles  ${GELB}in $(pwd)\n${PINK} (mit absoluter Zeit und Gruppenberechtigung): ${RESET}\t" && \
    lsd --almost-all --total-size --date "+%d. %b %Y %H:%M Uhr" \
        --classify --group-dirs "first" --no-symlink --hyperlink "always" \
        --long --size short --header \
        --blocks "permission,size,links,name,user,group,date" 2> /dev/null'
alias lt='echo -e "\t${PINK} LSD ${LILA}...mit alles ${GELB}in $(pwd)${PINK} --reverse --time-sort: ${RESET} \t" && \
    lsd --almost-all --total-size --group-dirs "first"  \
        --classify --no-symlink --hyperlink "always" \
        --long --size "short" --header --reverse \
        --blocks "size,links,name,date" --timesort 2> /dev/null'
        

alias lx='echo -e "\t${PINK} LSD ${LILA}...mit  alles  ${GELB}in $(pwd)${PINK}--reverse --extension-sort: ${RESET}\t" && \
    lsd --almost-all --total-size --classify --group-dirs "first" \
        --date "relative" --no-symlink --hyperlink "always" \
        --long --size "short" --reverse --header \
        --blocks "size,links,name,user,date"    --extensionsort 2> /dev/null'

# --- Klassische Werkzeuge ---
alias ..='cd ..'
alias Df='echo -e "\t${PINK}df -Tha --total ${RESET}\n" && df -Tha --total'
alias fhere='echo -e "\t${PINK}find . -name $1 {RESET}\n" && find . -name'
alias free='echo -e "\t${PINK}free -gt {RESET}\n" && free -gt'
alias PS='echo -e "\t${PINK} ps auxf{RESET}\n" && ps auxf'
alias psg='echo -e "\t${PINK}ps aux | grep -v grep | grep -i -e VSZ -e {RESET}\n" && ps aux | grep -v grep | grep -i -e VSZ -e'
alias wget="wget -c"
alias top="btop"
alias DF='echo -e "\t${PINK} pydf -hgB{RESET}\n" && pydf -hgB'
alias EIN="shutdown -r now"
#alias AUS="sudo nala update && sudo shutdown now"

mcd () {
	echo -e "\t${PINK} Verzeichnis${GREEN} $1 ist angelegt!${RESET}\n"
    mkdir -p "$1"
    cd "$1"
}

# --- Tipfehler & Shortcuts ---
alias cd..='echo -e "\t${PINK}Gehe ein Verzeichnis höher${RESET}\n" && cd ..'
# alias c='clear; motd || neo0'
alias c='clear; neo0'
alias q='echo -e "\t${PINK}Beenden${RESET}\n" && exit'
alias lol='alias | sort -k1,1 -k1.1,1.2 -k1.3,1.4| clolcat; echo -e "\n${GREEN}... das sind die aktuellen aliase, alphabetisch sortiert ${RESET}\n"'

#	________________________________________________________________________________
alias GIT='echo -e "\t${PINK}git aliase aus Zeile 545 bis 620\t $ZDOTDIR/aliases.zsh  ${RESET}\n" && \
    bat --wrap=auto --decorations=always \
        --theme=Coldark-Dark --line-range=545:620 "$ZDOTDIR/aliases.zsh"'
#	_________________________________________font: univers_______________________
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
#	------------------------------------------------------------------------------
# Git Status
alias gs='echo -e "${GELB}\nZeigt den Status des Arbeitsverzeichnisses und des Staging-Bereichs an${RESET}\n" && git status'
alias gsss='echo -e "${PINK}\n\t git status --short ${RESET} with abbr.:${RESET}\n${GELB}?? ... Untracked files${RESET}\t${GELB}U ... Files with merge conflicts${RESET}\t ${GELB}A ... New files added to staging ${RESET}\t${GELB}M ... Modified files${RESET}\t${GELB}D ... Deleted files${RESET}\t${GELB}R ... Renamed files${RESET}\t${GELB}C ... Copied files${RESET}\n" && git status -s'
gss() {
    cowsay -nW 60 "$(echo -e "${NIGHT}[Git Status]${RESET}\n$(git status -s)")"
    echo -e "\n${PINK}Legende:${RASP}
   M: Modified |  A: Staged
   D: Deleted  |  R: Renamed
   C: Copied   |  ?: Untracked${RESET}"
}
# Git Add
alias ga='echo -e "${GELB}\nFügt Änderungen im Arbeitsverzeichnis zum Staging-Bereich hinzu${RESET}\n" && git add'
# Git Push
alias gp='echo -e "${GELB}\nPushed lokale Änderungen auf den Remote-Branch${RESET}\n" && git push'
# alias gpo='echo -e "${GELBninjas2}\nPushed lokale Änderungen auf den Remote-Branch \"origin\"${RESET}\n" && git push origin'
# alias gpof='echo -e "${GELB}\nForce-Pushed lokale Änderungen auf den Remote-Branch \"origin\" mit Lease-Check${RESET}\n" && git push origin --force-with-lease'
# alias gpofn='echo -e "${GELB}\nForce-Pushed lokale Änderungen auf den Remote-Branch \"origin\" mit Lease-Check und ohne Verifizierung${RESET}\n" && git push origin --force-with-lease --no-verify'
# alias gpt='echo -e "${GELB}\nPushed alle Tags auf den Remote-Branch${RESET}\n" && git push --tag'
# Git Tag
# alias gtd='echo -e "${GELB}\nLöscht einen lokalen Tag${RESET}\n" && git tag --delete'
# alias gtdr='echo -e "${GELB}\nLöscht einen Remote-Tag${RESET}\n" && git tag --delete origin'
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
alias gblog="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:red)%(refname:short)%(color:reset) - %(color:yellow)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:blue)%(committerdate:relative)%(color:reset))'"
#	_______GIT - AUSGABE ENDE___________________________________________


# 	  Globale Aliase (werden überall in der Zeile expandiert)
# 	  usage% file G 'pattern'
# ### ---------------------------  ####
# Lädt Audio von YouTube als MP3 (192k), entfernt Sponsorblock-Segmente, bettet Metadaten/Thumbnail ein, begrenzt Dateinamen auf 48 Zeichen, zeigt benutzerdefinierten Download-Fortschritt.
alias -g YTA='yt-dlp --audio-quality 192k  --audio-format mp3 \ 
                 --progress --sponsorblock-remove all \
                 -x --embed-metadata --embed-thumbnail --no-mtime --console-title  \ 
                 --restrict-filenames --output "%(title).48s.%(ext)s" \
                 --progress-template "%(progress._percent_str)s of 100% | with %(progress._speed_str)s | %(progress._eta_str)s remaining" "$1"'

# Lädt Video von YouTube als MP4, entfernt Sponsorblock-Segmente, bettet Metadaten/Thumbnail ein, begrenzt Dateinamen auf 48 Zeichen, zeigt benutzerdefinierten Download-Fortschritt.
alias -g YTV='yt-dlp --audio-quality 192k --remux-video mp4 \ 
                 --progress --sponsorblock-remove all \
                 -x --embed-metadata --embed-thumbnail --no-mtime --console-title  \ 
                 --restrict-filenames --output "%(title).48s.%(ext)s" \
                 --progress-template "%(progress._percent_str)s of 100% | with %(progress._speed_str)s | %(progress._eta_str)s remaining" "$1"'


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
alias -g H='--help'
alias -g N0='2> /dev/null'
alias -g D0='2> /dev/null'
alias -g MM='&& echo "Success" || echo "Failed"'

# dahinter PKGS name, er letzte Pfad ist der vollständige Pfad zum gebauten Paket im Nix-Store. Ohne --no-out-link würde Nix einen Symlink namens result im aktuellen Verzeichnis erstellen, der auf diesen Pfad zeigt.
alias -g NN="nix-build --no-out-link '<nixpkgs>' -A"  

#   Suffix-Aliase (werden ausgeführt, wenn ein Dateiname als Befehl eingegeben wird)
### -----------------------------------------------------  ####
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm,opus,flac}='vlc'
# alias -s mp4='vlc --fullscreen --no-video-title-show --no-video-border'
alias -s {jpg,jpeg,png,bmp,svg,gif,webp}='kitty +kitten icat'
alias -s {js,json,env,html,css,toml}='bat -p'
alias -s {conf}='micro -filetype bash'
alias -s {nix}='gnome-text-editor &'
alias -s {pdf,otf,xls}='xreader -w &'
alias -s html='firefox &'
alias -s py=python
alias -s log=less
# Die folgende Definition überschreibt die vorherige für .md-Dateien.
alias -s {md}='marker --preview --display=:0 &'
alias -s {txt}='micro -filetype bash'

# "Run" ssh links to clone repos
# % git@github.com:stefanjudis/dotfiles.git # wird zu
# % git clone git@github.com:stefanjudis/dotfiles.git
# alias -s git="git clone"

################################################################
# alias mangconf='echo -e "\t${PINK}Öffne MangoHud Konfigurationsdatei${RESET}" && micro -filetype bash "$XDG_CONFIG_HOME/MangoHud/MangoHud.conf"'
# alias mango='echo -e "\t${PINK}Starte glxgears mit MangoHud Overlay${RESET}" && mangohud glxgears &'
# alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia-settings-rc"'
# Ende der Alias-Definitionen
