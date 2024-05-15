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


#alias NIXtrash = 'nix-collect-garbage -d --delete-older-than 14d'

#alias 1SCR='zsh -c $XDG_CONFIG_HOME/screenlayout/1.sh'
#alias 2SCR='zsh -c $XDG_CONFIG_HOME/screenlayout/2.sh'
#alias 3SCR='zsh -c $XDG_CONFIG_HOME/screenlayout/3.sh'
alias untar='tar -xvjf' 

alias neo1='echo -e "\t${PINK} neofetch w/ ${LILA} $XDG_CONFIG_HOME/neofetch/neofetch-short.conf  ${RESET}\t" \
 &&	neofetch --config $XDG_CONFIG_HOME/neofetch/neofetch-short.conf'
alias neo2='echo -e "\t${PINK} neofetch w/ ${LILA} $XDG_CONFIG_HOME/neofetch/config2.conf  ${RESET}\t" \
&& neofetch --config $XDG_CONFIG_HOME/neofetch/config2.conf'
alias neo3='echo -e "\t${PINK} neofetch w/ ${LILA} $XDG_CONFIG_HOME/neofetch/neofetch-long.conf  ${RESET}\t" \
 &&	neofetch --config $XDG_CONFIG_HOME/neofetch/neofetch-long.conf'
 
alias hack="hackertyper"		
alias NIXpkgs='lsd --oneline --classify --no-symlink /run/current-system/sw/bin/'
alias NIXenv="nix-env --query --installed" # um eine Liste aller installierten Pakete anzuzeigen
alias NIXinfo='nix-shell -p nix-info --run "nix-info -m"' # öffnet eine temporäre Shell-Umgebung mit einem bestimmten Paket installiert und führt dann einen Befehl aus. In diesem Fall wird das Paket nix-info installiert und der Befehl nix-info -m ausgeführt, der Informationen über die Nix-Installation gib
alias -g NIXref='nix-store -q --references /nix/store/' #Zeige die direkten Abhängigkeiten eines Pakets an
# nix-store -q --references --recursive # alle Abhängigkeiten eines Pakets rekursiv an.
# nix-store -q --referrers /nix/store/ #  Finde heraus, welche anderen Pakete von einem bestimmten Paket abhängen.

alias NIXconf="sudo micro /etc/nixos/configuration.nix"
alias Nconf=NIXconf
alias NIXupdate='sudo nixos-rebuild switch && xcowthink --image="$HOME/bilder/nixOS-logo.png" --time=3 --at=1200,200 --monitor=0 --left --font=unifont "UPDATE: nixos-rebuild switch ist jetzt fertig"'
alias Nupt=NIXupdate

alias NIXupgrade='sudo nixos-rebuild switch --upgrade && xcowthink --image="$HOME/bilder/nixOS-logo.png" --time=10 --at=1200,200 --monitor=0 --left --font=unifont "UPGRADE: nixos-rebuild switch ist jetzt fertig"'
alias Nupg=NIXupgrade

alias NIXboot='echo -e "\t${PINK} shows boota-able config.nix ${LILA}which can select by boot mgr grub" && eza /nix/var/nix/profiles/* --long --no-time --no-user --no-permissions --header --almost-all --grid#'

alias NIXHWcopy="cp --verbose /etc/nixos/hardware-configuration.nix /share/nixos/$(date +%F)_hardware-configuration.nix"
alias NIXcopy="cp --verbose /etc/nixos/configuration.nix $HOME/share/nixos/$(date +%F)_configuration.nix"





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


alias MICsett='micro $XDG_CONFIG_HOME/micro/settings.json'
alias MICbin='micro  $XDG_CONFIG_HOME/micro/bindings.json'

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

alias ZFUNC='nano "$ZDOTDIR/zfunctions.zsh " && source "$ZDOTDIR/zfunctions.zsh " && echo -e "\n\t${PINK}source $ZDOTDIR/zfunctions.zsh  erfolgreich!${RESET}\n" || echo -e "\n\t${GELB}source $ZDOTDIR/zfunctions.zsh   ---NICHT---  erfolgreich!${RESET}\n"'

 
alias ZCOPY='echo -e "\n" && cp --verbose "$ZDOTDIR/.zshrc" "$ZDOTDIR/bkp/$(date +'%F').nix.zshrc.zsh" && cp --verbose "$HOME/.zshenv" "$ZDOTDIR/bkp/$(date +'%F').nix.zshenv.zsh"  && cp --verbose "$ZDOTDIR/aliases.zsh" "$ZDOTDIR/bkp/$(date +'%F')nix.aliases.zsh"'

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

alias CHmod='find . -maxdepth 1 -type f \( -name "*.sh" -o -name "*.zsh" \) -exec chmod --verbose u+x {} +'

#alias debug='echo "Debugging..."; set -x'

alias LOG='cat "$ZDOTDIR/log_error/log_error.txt" | grep "error" | sort'
alias LOGseparate='tail -f "$ZDOTDIR/log_error/log_error.txt"'
alias LOGinline='less -F "$ZDOTDIR/log_error/log_error.txt"'




### ---------------------------  #### 
# ┌─┐┬  ┌─┐┌┐ ┌─┐┬  ┌─┐  ┌─┐┌─┐┬ ┬  ┌─┐┬  ┬┌─┐┌─┐┌─┐
# │ ┬│  │ │├┴┐├─┤│  ├┤   ┌─┘└─┐├─┤  ├─┤│  │├─┤└─┐├┤
# └─┘┴─┘└─┘└─┘┴ ┴┴─┘└─┘  └─┘└─┘┴ ┴  ┴ ┴┴─┘┴┴ ┴└─┘└─┘
# ..usage % file G 'pattern'
### ---------------------------  #### 
alias -g HG='--help 2>&1 | grep'

alias -g N0='2> /dev/null'
alias -g D0='2> /dev/null'


alias -g SRC='source'
alias -g LL=' | less -R'
alias -g L=' | less -X -j5 --tilde --save-marks \
				--incsearch --RAW-CONTROL-CHARS \
				--LINE-NUMBERS --line-num-width=3 \
				--quit-if-one-screen --use-color \
				--color=NWr --color=EwR  --color=PbC --color=Swb'

alias -g G='|grep --ignore-case --color=auto' 

alias -g H='--help'

alias fgrep='fgrep --color=auto'
alias  egrep='egrep --color=auto'
 #... grep ... in History auf WORD
alias -g  h='history' 

# zhistory.zsh  
alias g2history='cat "$ZDOTDIR/zhistory.zsh"  | grep -i --colour=always'
alias g2h=g2history
alias h2g=g2history

#grep...auf [ENV] printable enviroment variable auf WORD
alias g2env='printenv | grep -i --colour=always'
alias env2g='g2env'
#... grep ... in printable aliases auf WORDnc	
alias g2ali='alias | grep -i --colour=always'
alias ali2g='g2ali'
alias  g2lol='g2ali'
alias  lol2g='g2ali'


### ---------------------------  #### 
#        ┌─┐┬ ┬┌─┐┌─┐┬─┐ ┬  
#        └─┐│ │├┤ ├┤ │┌┴┬┘  
#        └─┘└─┘└  └  ┴┴ └─  
# ┌─┐┌─┐┬ ┬  ┌─┐┬  ┬┌─┐┌─┐┌─┐
# ┌─┘└─┐├─┤  ├─┤│  │├─┤└─┐├┤ 
# └─┘└─┘┴ ┴  ┴ ┴┴─┘┴┴ ┴└─┘└─┘
### ---------------------------  #### 
#alias -s mp4='vlc --fullscreen \				  --no-video-title-show \				  --no-video-border 	  --no-video-menu'
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm,opus,flac}='vlc'
alias -s {jpg,jpeg,png,bmp,svg,gif}='kitty +kitten icat'
alias -s md='marker --preview' #--display
alias -s {js,json,env,html,css,toml}='bat'
#alias -s {bash,zsh,csh,txt}='micro'
alias -s {txt}='micro'

#alias -s py = python
#alias -s log = less 
# "Run" ssh links to clone repos
# % git@github.com:stefanjudis/dotfiles.git # wird zu 
# % git clone git@github.com:stefanjudis/dotfiles.git
# alias -s git="git clone"


##### --%%%%%%%%%%%%%%-- #####
## ---------------------------  ## 
##  CAT/ BATCAT      
## ---------------------------  ## 
##### --%%%%%%%%%%%%%%-- #####
# gute themes für batcat ansi OneHalfDark Dracula Coldark-Dark

alias bat='bat --plain --terminal-width 76'
alias bat1='bat --plain --force-colorization  --theme=ansi'
alias bat2='bat --number --theme=Dracula'
alias bat3='bat --number --decorations=always --color=always --theme=Coldark-Dark'
alias bat4='bat --number  --decorations=always --color=always --theme=OneHalfDark'

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

#gtk-update-icon-cache

##### --%%%%%%%%%%%%%%-- #####
## ---------------------------  ## 
##       e x a / e z a .. ls  ll  lh  ld ...

alias e1='echo -e "\t${GELB} eza --tree -level 1 --git ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --color-scale 	--no-time --no-permissions  \
	 	 --tree 		--level 1	--git'
	 	 
alias e2='echo -e "\t${GELB} eza --tree -level 2 --git ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --color-scale 	--no-time --no-permissions  \
	 	 --tree 		--level 2	--git'
	 	 
alias e3='echo -e "\t${GELB} eza --tree -level 3 --git ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --color-scale 	--no-time --no-permissions  \
	 	 --tree 		--level 3	--git'

alias e4='echo -e "\t${GELB} eza --tree -level 4 --git ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --no-time --no-permissions  \
	 	 --color-scale age --color-scale-mode gradient \
	 	 --tree 		--level 4	--git'

alias e99='echo -e "\t${GELB} eza --tree -level 99 --git ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --colour-scale all --color-scale-mode gradient	--no-time \
	 	 --no-permissions   --tree 		--level 99	--git'

alias le='echo -e "eza --color-scale age --color-scale-mode gradient" && \
		eza --almost-all 	 --total-size \
			--group-directories-first --header \
			-no-permissions --colour-scale all --color-scale-mode gradient'

alias ee='eza --grid --long --no-permissions --total-size --no-time --almost-all --header --colour-scale all --color-scale-mode gradient'

alias lf='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} only (hidden and non-hidden)files:${RESET}" && \
 \
 		eza 	--grid 		 --no-permissions --long \
 				--total-size --almost-all 	  --no-time \
 				--color-scale age --color-scale-mode gradient \
 				--classify --header --only-files'

alias ld='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} only (hidden and non-hidden)directorys:${RESET}\n" && \
 \
 		eza 	--grid 		 --no-permissions --long \
 				--total-size --almost-all 	  --no-time \
 				--color-scale age --color-scale-mode gradient \
 				--classify --header --only-dirs'
# ## eza ende 
alias lg='echo -e "\t${PINK} Zeigt alles in ${GELB}$(pwd)${PINK} (hidden) Files und (hidden) directory:${RESET}\n" 	&&  				\
  											\
  lsd 	--size short  	  	--human-readable \
   		--group-dirs=none 	--almost-all 	\
   		--classify'
## lsd

alias l='echo -e "\t${PINK} LSD ohne alles ${RESET}\n" && \
  	lsd 	--classify --group-dirs=first'

alias ll='echo -e "\t${PINK} LSD ${LILA} REVERSE ... mit  alles  ${GELB}in $(pwd)${PINK}(mit relativer Zeit ohne Gruppenberechtigung): ${RESET}\t" &&	\
															\
	lsd --almost-all --total-size 							\
	    --classify 	  			--group-dirs=first 			\
		--date "relative" 		--no-symlink  				\
		--hyperlink 'always' --long  						\
		--size short 		 --header  						\
			--blocks 'size'  --blocks 'links' --blocks 'name' \
			--blocks 'user' --blocks 'date' '
	
alias lll='echo -e "\t${PINK} LSD ${LILA}  ... mit  alles  ${GELB}in $(pwd)${PINK} (mit absoluter Zeit und Gruppenberechtigung): ${RESET}\t" && \
	\
	lsd --almost-all --total-size 	--date="+%d. %b %Y %H:%M Uhr" 	   	\
	    --classify 	  	--group-dirs=first 	\
		--no-symlink  	--hyperlink 'always' \
		--long  		--size short 		\
		--header 		--blocks 'permission' --blocks 'size'  --blocks 'links' \
						--blocks 'name' --blocks 'user' --blocks 'date' '

alias lx='echo -e "\t${PINK} LSD ${LILA} REVERSE ... mit  alles  ${GELB}in $(pwd)${PINK}--extension-sort: ${RESET}\t" &&	   \
													\
	lsd --almost-all 		--total-size  --extensionsort \
		--classify 		  --group-dirs=none \
            --date "relative" 	--no-symlink  	\
            --hyperlink 'always' 				\
            --long				--size short 	\
            --timesort 			--reverse \
     		--header  --blocks 'size'  --blocks 'links'  \
     			--blocks 'name' --blocks 'user' --blocks 'date'   '

	              
 alias lt='echo -e "\n\t${LILA}Sortierung nach ${PINK}--timesort --reverse ${GELB}in $(pwd)${RESET}\n"  && \
 		\
 		lsd --almost-all --total-size --timesort \
            --classify 		  --group-dirs=none \
            --date "relative" 	--no-symlink  	\
            --hyperlink 'always' 				\
            --long				--size short 	\
            --timesort 			--reverse \
     		--header  --blocks 'size'  --blocks 'links'  \
     			--blocks 'name' --blocks 'user' --blocks 'date'             '
		
# alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '
#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '
#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '
#alias l='echo -e "\n\t${PINK}   ${RESET}\n"	&& '

# ---------------------------  ## 
##### --%%%%%%%%%%%%%%-- #####



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

# Häufige Tipfehler
alias cd..='echo -e "\t${PINK}Gehe ein Verzeichnis höher${RESET}\n" && cd ..' 

#alias rm='echo -e "\t${PINK}Entferne Dateien/Verzeichnisse (bestätigt)${RESET}\n" && rm --verbose --recursive -i'
#alias cp --verbose='echo -e "\t${PINK}Kopiere Dateien/Verzeichnisse cp --verbose -ivr(bestätigt)${RESET}\n" && cp --verbose --verbose --recursive --interactive'
#alias mv='echo -e "\t${PINK}Verschiebe/umbenenne Dateien/Verzeichnisse (interacive, verbose)${RESET}\n" && mv -v -i'
#alias alais='echo -e "\t${PINK}Alias für Alias${RESET}\n" && alias'
#alias tdlr='echo -e "\t${GELB}Zeige verkürzte Handbücher (TL;DR)${RESET}\n" && tldr'
#alias T='echo -e "\t${GELB}Zeige verkürzte Handbücher (TL;DR)${RESET}\n" && tldr'
#alias _='echo -e "\t${PINK}Führe als Superuser (sudo) aus${RESET}\n" && sudo'

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
# export SCRIPT_RUN_aliaseszsh="true"

 


