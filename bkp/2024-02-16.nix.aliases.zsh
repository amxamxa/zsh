#!/usr/bin/env zsh
###########################################
##  filename:    	aliases.zsh
##  filepath:     	/home/ZSH/
##  author:       	mxx
##  file save date: 	04.12.23
##  file creation\
##  date: 	[yy-mmm]: 23 oct
##  file status		 work in progess
##  comments: 	   - ^e edit
###########################################

alias neo2='neofetch --config $XDG_CONFIG_HOME/neofetch/config2.conf'


alias hack="hackertyper"		
alias NIXpkgs='lsd --oneline --classify --no-symlink /run/current-system/sw/bin/'

alias -g NIXref='nix-store -q --references'
alias NIXconf="sudo micro /etc/nixos/configuration.nix"
alias NIXupt="sudo nixos-rebuild switch"
alias NIXHWcopy="cp /etc/nixos/hardware-configuration.nix /share/nixos/$(date +%F)_hardware-configuration.nix"
alias NIXcopy="cp /etc/nixos/configuration.nix /share/nixos/$(date +%F)_configuration.nix"
alias NIXenv="nix-env --query --installed"
alias NIXinfo='nx-shell -p nix-info --run "nix-info -m"'




##### --%%%%%%%%%%%%%%-- #####
##
##      N E U       ##
##
##### --%%%%%%%%%%%%%%-- #####

#alias AUDIO() {
# ="cat /proc/asound/cards && aplay -l && cat /proc/asound/card*/codec*"
#while read -r KARTE; do
#  while read -r GERÄT; do
#    local SAMPLE_RATE=$(aplay -l | grep "$GERÄT" | awk '{print $NF}' | sed 's/[[:space:]]\+//g')#
#    local BIT_TIEFE=$(aplay -l | grep "$GERÄT" | awk '{print $(NF-1)}' | sed 's/[[:space:]]\+//g')
#    local KANÄLE=$(aplay -l | grep "$GERÄT" | awk '{print $(NF-2)}' | sed 's/[[:space:]]\+//g')#
#
#    while read -r CODEC; do
#      TABELLE="$TABELLE\n| $KARTE | $GERÄT | $CODEC | $SAMPLE_RATE | $BIT_TIEFE | $KANÄLE |"
#    done < <(echo "$CODECS" | grep "$KARTE")
#  done < <(echo "$DEVICES" | grep "$KARTE")
#done < <(echo "$CARDS")
#}

#alias sudo='sudo --preserve-env=HOME'


alias diff='colordiff --ignore-case --ignore-tab-expansion --ignore-trailing-space --ignore-space-change --ignore-all-space --ignore-blank-lines'

alias lsblk='echo -e "\n\t${LILA}lsblk --width 80 --merge --zoned --ascii --topology --output MODEL,MOUNTPOINTS,PATH,SIZE,TRAN,LABEL,FSTYPE,TYPE${RESET}" && lsblk --width 80 --merge --zoned --ascii --topology --output MODEL,MOUNTPOINTS,PATH,SIZE,TRAN,LABEL,FSTYPE,TYPE'

alias MICsett='micro /home/mxx/.config/micro/settings.json'
alias MICbin='micro /home/mxx/.config/micro/bindings.json'

alias TREE2='tree -L 2 -s -h -F -C -a --du --prune $(pwd)'
alias TREE4='tree -L 4 -s -h -F -C -a --du --prune $(pwd)'
alias TREE8='tree -L 8 -s -h -F -C -a --du --prune $(pwd)'

# Terminal linker Screen, NordEast, 2x
alias Tl2x='gnome-terminal --geometry 70x26+387+514; gnome-terminal --geometry 70x26+387+4'
# Terminal rechter Screen, Nord, 2x
alias Tr2x='gnome-terminal --geometry 79x21+1694+768; gnome-terminal --geometry 79x17+1692+1147'

##### --%%%%%%%%%%%%%%-- #####
##      ANSAGE      ##
##### --%%%%%%%%%%%%%%-- #####
alias VOCtime='echo -e "Es ist jetzte $(date "+%R").Heute ist $(date "+%A")" > $HOME/temp/time.tmp && espeak-ng -v mb-de5 -s 130 -p 40 95 -g 20 -k 20 -b 2 -f $HOME/temp/time.tmp'
alias VOCdate='echo -e "Heute ist $(date "+%A")! \vWir haben den $(date "+%-d ten %BNach unserer neuen Zeitrechnung sind wir im Jahre %Y! ")" > $HOME/temp/date.tmp && espeak-ng -v mb-de5 -s 130 -p 40 95 -g 20 -k 20 -b 2 -f $HOME/temp/date.tmp'

##### --%%%%%%%%%%%%%%-- #####
##							 
##      * *   Z S H *  *           
##  .zshenv .zshrc aliases.zsh
##  
##### --%%%%%%%%%%%%%%-- #####
alias ZRC='nano "$ZDOTDIR/.zshrc" && source "$ZDOTDIR/.zshrc" && echo -e "\n\t${PINK}source $ZDOTDIR/.zshrc erfolgreich!${RESET}\n" || echo -e "\n\t${GELB}source $ZDOTDIR/.zshrc  ---NICHT---  erfolgreich!${RESET}\n"'

alias ZENV='nano "$HOME/.zshenv" && source "$HOME/.zshenv" && echo -e "\n\t${PINK}source ~/.zshenv erfolgreich!${RESET}\n" || echo -e "\n\t${GELB}source ~/.zshenv ---NICHT---  erfolgreich!${RESET}\n"'

alias ZALI='nano $ZDOTDIR/aliases.zsh && source $ZDOTDIR/aliases.zsh && echo -e "\n\t${PINK}source $ZDOTDIR/aliases.zsh erfolgreich!${RESET}\n" || echo -e "\n\t${GELB}source $ZDOTDIR/aliases.zsh   ---NICHT---  erfolgreich!${RESET}\n"'	
 
alias ZCOPY='echo -e "\n" && cp "$ZDOTDIR/.zshrc" "$ZDOTDIR/bkp/$(date +'%F').nix.zshrc.zsh" && cp "$HOME/.zshenv" "$ZDOTDIR/bkp/$(date +'%F').nix.zshenv.zsh"  && cp "$ZDOTDIR/aliases.zsh" "$ZDOTDIR/bkp/$(date +'%F')nix.aliases.zsh"'
alias ZSHoptions=setopt
#alias wh_fuck='dpkg -L' # alle Dateien finden, die mit 'apt install' installiert wurde
##### --%%%%%%%%%%%%%%-- #####
### -------------------- ##
##     gnome gui windows ##
### -------------------- ##
##### --%%%%%%%%%%%%%%-- #####
alias WMinfo='echo -e "\n\t${PINK}...2xklicken!  zeigt Parameter des Windows an!${RESET}\n" && xprop | grep --color=auto -E WM_CLASS && xwininfo | grep --color=auto geometry'
alias WMverbose='echo -e "\n\t${PINK}\n 2xklicken!... zeigt Parameter des Windows an!${RESET}\n" && xprop | grep --color=auto -e "WM_CLASS(STRING)" -e "*SIZE*" -e "WM_PROTOCOLS(ATOM):" -e "geometry" -e "_NET_WM_ALLOWED_ACTIONS(ATOM)" && xwininfo | grep --color=auto geometry'
##### --%%%%%%%%%%%%%%-- #####
## --------------------  ## 
##     mittelneu
## --------------------  ##
##### --%%%%%%%%%%%%%%-- #####

alias nano=micro
alias edit=micro
alias DATE='echo -e "\t${PINK}Zeige das aktuelle Datum  $(date "+%A, %-d. %B %Y"):{$RESET}" && echo -e "${GELB} $(date "+%A, %-d. %B %Y")${RESET} \n "&& echo -e "${PINK} oder $ (date +%F_%H-%M)\t ${RESET}" 	&& echo -e "${GELB} $(date "+%F_%H-%M") ${RESET}"'

alias CHmod='chmod --verbose --recursive u+x $(pwd)/*.sh && chmod --verbose --recursive u+x $(pwd)/*.zsh'
#alias debug='echo "Debugging..."; set -x'

alias LOG='cat "$ZDOTDIR/log_error/log_error.txt" | grep "error" | sort'
alias LOGseparate='tail -f "$ZDOTDIR/log_error/log_error.txt"'
alias LOGinline='less -F "$ZDOTDIR/log_error/log_error.txt"'

##### --%%%%%%%%%%%%%%-- #####
## ---------------------------  ## 
##    globale aliase (zsh only)
## ---------------------------  ##
##### --%%%%%%%%%%%%%%-- #####

alias -g SRC='source'
alias -g L='|less -X -j5 --tilde --save-marks --incsearch --RAW-CONTROL-CHARS --LINE-NUMBERS --line-num-width=3 --quit-if-one-screen --use-color --color=NWr --color=EwR  --color=PbC --color=Swb'
alias -g G='|grep --ignore-case --color=auto' # ..usage$ file G pattern
alias -g H='--help'
#alias -g F='|tldr'

## ---------------------------  ## 
##    suffix alias (zsh only)
## ---------------------------  ## 
#alias -s ffuck='tldr'
alias -s mp4='vlc --fullscreen --no-video-title-show --no-video-border --no-video-menu'
alias -s mp3='vlc'
alias -s avi='vlc'
alias -s opus='vlc'
alias -s flac='vlc'
alias -s m4a='vlc'
alias -s mkv='vlc'
alias -s jpg='img2sixel'
alias -s jpeg='img2sixel'
alias -s png='img2sixel'
alias -s jpeg='img2sixel'
#alias -s sh='micro'
#alias -s zsh='micro'

##### --%%%%%%%%%%%%%%-- #####
## ---------------------------  ## 
##  CAT/ BATCAT      
## ---------------------------  ## 
##### --%%%%%%%%%%%%%%-- #####
alias batcat='bat'
alias bat='batcat --plain --terminal-width 80'
# gute themes für batcat ansi OneHalfDark Dracula Coldark-Dark
alias bat1='batcat -pp --force-colorization --terminal-width 76 --theme=ansi'
alias bat2='batcat --force-colorization --terminal-width 76 --wrap=auto --theme=Dracula'
alias bat3='batcat --number --terminal-width 76 --decorations=always --color=always --wrap=auto --theme=Coldark-Dark'
alias bat4='batcat --number --terminal-width 76 --decorations=always --color=always --wrap=auto --theme=OneHalfDark'

##### --%%%%%%%%%%%%%%-- #####
## ---------------------------  ## 
## biggest stuff ??
## ---------------------------  ## 
##### --%%%%%%%%%%%%%%-- #####

# alias DU='echo -e "\t${PINK}Zeige die 22 größten Verzeichnisse und Dateien${RESET}\n" && command du -cah --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc' | sort -hr | head -n 22' 
D3() {
 echo -e "\n\t${GELB} du --max-depth=3 --separate-dirs --threshold=16K -BM -x $(pwd) 2> /dev/null | sort -hr | head -n 24${LILA} \t... wir reden über Pfad $(pwd)${RESET}}\n"
du --human-readable --max-depth=3 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc' $pwd 2> /dev/null | sort -hr | head -n 24
}
D1() {
 echo -e "\n\t${GELB} du --max-depth=1 --separate-dirs --threshold=16K -BM -x $(pwd) 2> /dev/null | sort -hr | head -n 24${LILA} \t... wir reden über Pfad $(pwd)${RESET}}\n"
du --human-readable --max-depth=1 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc' $pwd 2> /dev/null | sort -hr | head -n 24
}
##### --%%%%%%%%%%%%%%-- #####
## ---------------------------  ## 
##    ls  ll  lh  ld ...
## ---------------------------  ## 
##### --%%%%%%%%%%%%%%-- #####
# elementary-icon-theme faba-icon-theme gnome-colors faenza-icon-theme gnome-icon-theme-yasis gnome-icon-theme-nuovo  oxygen-icon-theme  obsidian-icon-theme volumeicon-alsa
#gtk-update-icon-cache
alias l='echo -e "\t${PINK} LSD ohne alles ${RESET}\n" && 	lsd --total-size --icon-theme fancy --human-readable --classify --hyperlink always --dereference'

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
	



alias la='echo -e "\t${PINK} Zeigt alles in ${GELB}$(pwd)${PINK} (hidden) Files und (hidden) directory:${RESET}\n" && lsd --size short \ 
	--human-readable  \
	--group-dirs first \
	--almost-all \
	--classify *.*
	'
#alias lf='echo -e "\t${PINK} Zeigt alles in ${GELB}$(pwd)${PINK} (hidden) Files und (hidden) directory:${RESET}\n" && lsd --size short --human-readable --group-dirs first --almost-all --classify'


#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '
#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '
#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '
#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '
#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '



export LS_OPTS='--color=force'
alias ls='ls ${LS_OPTS}'
alias sl='ls'
# all hidden ls -shdrp $(pwd) .*
# ls -shAdp --group-directories-first --color=force *

alias lh='echo -e "\n\t${PINK}Zeige nur versteckte Verzeichnisse und Dateien an${RESET}\n" && 	ls -pdAh --group-directories-first .*'
alias lf='echo -e "\n\t${PINK}Zeige nur Dateien an${RESET}\n\t\t" && 							ls -shdrp *.*'
#alias ld='echo -e "\n\t${PINK}Zeigt nur Ordner, exkl. versteckte${RESET}\n" && 					ls -shdrp */'
#alias la='echo -e "\n\t${PINK}ls -lahp: Zeigt alles, mit --group-directories-first${RESET}\n" && ls -lahp --group-directories-first'
alias lt='echo -e "\n\t${PINK}Liste TIME: nach Änderungsdatum (älteste zuerst)${RESET}\n\t${GELB}ls -AsltpGHp${RESET}" && ls -AsltGHp'
alias lx='echo -e "\n\t${PINK} Liste EXT:  sflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateortiert nach File-Eextension${RESET}\n\t${GELB}		ls -AXlGhp${RESET}\n" && ls -AXlGhp'

# export LS_OPTS='--color=force'
# alias ls='ls ${LS_OPTS}'
# alias sl='ls'
# # all hidden ls -shdrp $(pwd) .*
# # ls -shAdp --group-directories-first --color=force *
# alias l='echo -e "\n\t${PINK}ls -dsAhp --group-directories-first * ${RESET}\n"	&& 				ls -dsAhp --group-directories-first *'
# alias lh='echo -e "\n\t${PINK}Zeige nur versteckte Verzeichnisse und Dateien an${RESET}\n" && 	ls -pdAh --group-directories-first .*'
# alias lf='echo -e "\n\t${PINK}Zeige nur Dateien an${RESET}\n\t\t" && 							ls -shdrp *.*'
# alias ld='echo -e "\n\t${PINK}Zeigt nur Ordner, exkl. versteckte${RESET}\n" && 					ls -shdrp */'
# alias ll='echo -e "\n\t${PINK}Alles und als Liste und von unten nach OBEN${RESET}\n" && 		ls -alhrp'
# alias la='echo -e "\n\t${PINK}ls -lahp: Zeigt alles, mit --group-directories-first${RESET}\n" && ls -lahp --group-directories-first'
# alias lt='echo -e "\n\t${PINK}Liste TIME: nach Änderungsdatum (älteste zuerst)${RESET}\n\t${GELB}ls -AsltpGHp${RESET}" && ls -AsltGHp'
# alias lx='echo -e "\n\t${PINK} Liste EXT:  sortiert nach File-Eextension${RESET}\n\t${GELB}		ls -AXlGhp${RESET}\n" && ls -AXlGhp'

##### --%%%%%%%%%%%%%%-- #####
## ---------------------------  ## 
##       e x a 
## ---------------------------  ## 
##### --%%%%%%%%%%%%%%-- #####
alias e1='echo -e "\n\t${GELB} exa -A -l --tree --level 1--no-time --no-permissions --git --group-directories-first     ${RESET}\n" && exa --no-time --no-permissions --tree --level 1 --all --long --color-scflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateflatpak updateale --icons --git --group-directories-first'
  alias e2='echo -e "\n\t${GELB} exa --no-time --no-permissions -A -l --tree --level 2 --git --group-directories-first${RESET}\n" && exa --tree --level 2 --all --long --color-scale --icons --no-time --no-permissions --git --group-directories-first'
 alias e3='echo -e "\t${GELB} exa -A -l --tree -level 3--no-time --no-permissions --git --group-directories-first${RESET}\n" && exa --tree --level 3 --all --long --color-scale --icons --no-time --no-permissions --git --group-directories-first'
 alias e4='echo -e "\t${GELB} exa --no-time --no-permissions --A -l --tree -level 4 --git--group-directories-first${RESET}\n" && exa --tree --level 4 --all --long --color-scale --icons --no-time --no-permissions --git --group-directories-first'

 alias fgrep='fgrep --color=auto'
 alias egrep='egrep --color=auto'
 #... grep ... in History auf WORD
 alias h='history'
alias g2history='cat "$ZDOTDIR/.zhistory"  | grep -i --colour=always'
alias g2h=g2history

#grep...auf [ENV] printable enviroment variable auf WORD
alias g2env='printenv | grep -i --colour=always'

#... grep ... in printable aliases auf WORDnc	
alias g2ali='alias | grep -i --colour=always'
alias g2lol='g2ali'
alias lol2g='g2ali'

## ---------------------------  ## 
##  digitalocean.com/community/tutorials/an-introduction-to-useful-bash-aliases-and-functions
## ---------------------------  ## 
# NOK ncdu is an interactive ncurses display that you can browse and use to perform simple file actions
# alias NC ="ncdu"

# list our disk usage in human-readable units including filesystem type, and print a total at the bottom
alias df="df -Tha --total"

# alias du="du -ach | sort -h" # -a...allfiles/path -c...complete
alias fhere="find . -name "
alias free="free -gt"
alias ps="ps auxf"

# searches process for an argument
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# wget-c: continue download if problems
alias wget="wget -c" 
alias top="btop"
	

# upgraded utility for df as well that’s called pydf. It provides colorized output and text-based usage bars.
alias DF="pydf"

alias EIN="sudo shutdown -r now"
#alias AUS="sudo nala update && sudo shutdown now"


mcd () {  # make DIR
    mkdir -p $1
    cd $1
	}
alias cd..='echo -e "\t${PINK}Gehe ein Verzeichnis höher${RESET}\n" && cd ..' 
# Häufige Rechtschreibfehler
alias rm='echo -e "\t${PINK}Entferne Dateien/Verzeichnisse (bestätigt)${RESET}\n" && rm --verbose --recursive -i'
alias cp='echo -e "\t${PINK}Kopiere Dateien/Verzeichnisse cp -ivr(bestätigt)${RESET}\n" && cp --verbose --recursive --interactive'
alias mv='echo -e "\t${PINK}Verschiebe/umbenenne Dateien/Verzeichnisse (interacive, verbose)${RESET}\n" && mv -v -i'
#alias alais='echo -e "\t${PINK}Alias für Alias${RESET}\n" && alias'
alias tdlr='echo -e "\t${GELB}Zeige verkürzte Handbücher (TL;DR)${RESET}\n" && tldr'
#alias T='echo -e "\t${GELB}Zeige verkürzte Handbücher (TL;DR)${RESET}\n" && tldr'
alias _='echo -e "\t${PINK}Führe als Superuser (sudo) aus${RESET}\n" && sudo'
alias c='echo -e "\t${PINK}Bildschirm löschen${RESET}\n" && clear'
alias q='echo -e "\t${PINK}Beenden${RESET}\n" && exit'
alias lol="alias | sort -k1,1 -k1.1,1.2 -k1.3,1.4| clolcat"

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



# alias g='   '  #
# alias g='   '  #
# alias g='   '  #
# alias g='   '  #
# alias g='   '  #




# -->greeting.zsh aliases.zsh  
export SCRIPT_RUN_aliaseszsh="true"

 

