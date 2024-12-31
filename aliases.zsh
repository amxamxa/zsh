#!/usr/bin/env zsh
###########################################
##  filename:    	aliases.zsh
##  filepath:     	/share/zsh
##  author:       	mxx
##  file save date: 04.12.23
##  file creation\
##  date: 	[yy-mmm]: 23 oct
##  file status		 work in progess
##  comments: 	   - ^e edit
###########################################
# /*    */
# ________________________________________________________________
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
#_____________________________________________________________________________
alias FARBE='source_or_error "$ZDOTDIR/functions/colors.zsh" ||  source "$ZDOTDIR/functions/colors.zsh"'

alias man='man --wildcard' # dann wird die man-page auf Terminal gepagt!
alias RM~='find . -type f -name "*~" -delete'
alias gitgit='git config -f $GIT_CONFIG user.email "max.kempter@gmail.com" && \
	          git config -f $GIT_CONFIG user.name "amxamxa" 			   && \
	          git config -l | bat3 -l "sh"'
# && git config --show-origin  && git config --show-scope' # | grep user"
alias gitloc='git config -f ~/.gitlocal user.email "max.kempter@gmail.com"  && \
			  git config -f ~/.gitlocal user.name "amxamxa"					&& \
			  git config -l | bat3 -l "sh"'

alias COLsw='color-theme-switch && echo -e "${BROWN}color-theme-switch aus my-function.zsh${RESET}"'

alias COL+='theme.sh --dark -i2 >> color-theme.md  && echo -e "${BROWN}theme.sh --dark -i2 >> color-theme.md ${RESET}"'
alias FC-list='fc-list : family spacing outline scalable | grep -e spacing=100 -e spacing=90 | grep -e outline=True | grep -e scalable=True | sort'
alias cp='xcp --verbose'
#	______________________________
alias NIXpkgs='lsd --oneline --classify --no-symlink /run/current-system/sw/bin/'
alias NIXenv='nix-env --query --installed' # um eine Liste aller installierten Pakete anzuzeigen
alias NIXinfo='nix-shell -p nix-info --run "nix-info -m"' # öffnet eine temporäre Shell-Umgebung mit einem bestimmten Paket installiert und führt dann einen Befehl aus. In diesem Fall wird das Paket nix-info installiert und der Befehl nix-info -m ausgeführt, der Informationen über die Nix-Installation gib

alias -g NIXref='nix-store -q --references /nix/store/' #Zeige die direkten Abhängigkeiten eines Pakets an

# alias ='echo "Müll wird entleert!" &&  echo -e "{PINK}  lol" && sudo rm -v /nix/var/nix/gcroots/auto/* &&  sudo nix-collect-garbage -d && 	sudo nix-store --optimise -vvv'

# enviroment.nix 	packages.nix 	gpu.nix	xrandr.nix	cgit.nix	zsh.nix			users.nix
NIXconf() {
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

# alias NIXupdate='sudo nixos-rebuild switch --show-trace --verbose   |  \
#			cowsay 	"UPDATE: nixos-rebuild switch ist jetzt fertig" |  \
#			xcowthink --image="$HOME/bilder/nixOS-logo.png"  --time=3 --at=1200,200 --left \
#			"UPDATE: nixos-rebuild switch ist jetzt fertig"'  # /* --font=unifont  --monitor=0
alias Nupt=NIXupdate
# alias NIXupgrade='sudo nixos-rebuild switch --upgrade --show-trace -v && \
# 			xcowthink --image="$HOME/bilder/nixOS-logo.png" --time=10 --at=1200,200 --monitor=0 --left --font=unifont "UPGRADE: nixos-rebuild switch ist jetzt fertig"'
alias Nupg=NIXupgrade

alias NIXboot='echo -e "\t${PINK} shows boota-able config.nix ${LILA}which can select by grub" && \
	eza /nix/var/nix/profiles/* --long --no-time --no-user --no-permissions --header --almost-all --grid'

# alias NIXcurrentCopy='echo -e "\t${PINK}cp  /run/current-system/configuration.nix ${LILA}to /share/nixos/current-system-bkp${RESET}" && cp -fv /run/current-system/configuration.nix /share/nixos/current-system-bkp/$(date +%F)-conf.nix'
# alias NcurrCopy= NIXcurrentCopy

alias Ncopy=NIXcopy
#	_____________________________________________________zsh_______________
##      * *   Z S H *  *
##  .zshenv .zshrc aliases.zsh
 alias za='zoxide add'
 alias zq='zoxide query'
 alias zqi='zoxide query -i'
 alias zr='zoxide remove'
			 
alias ZRC='nano "$ZDOTDIR/.zshrc" && source "$ZDOTDIR/.zshrc" 			  \
	&& echo -e "\n\t${PINK}source $ZDOTDIR/.zshrc erfolgreich!${RESET}\n" \
	|| echo -e "\n\t${GELB}source $ZDOTDIR/.zshrc  ---NICHT---  erfolgreich!${RESET}\n"'
alias Zconf='ZRC'

# alias ZENV='micro -filetype zsh $HOME/.zshenv" && source "$HOME/.zshenv" && echo -e "\n\t${PINK}source ~/.zshenv erfolgreich!${RESET}\n" || echo -e "\n\t${GELB}source ~/.zshenv ---NICHT---  erfolgreich!${RESET}\n"'
ZEconf='ZENV'
alias ZALI='micro $ZDOTDIR/aliases.zsh \
		&& source $ZDOTDIR/aliases.zsh 				 \
		&& echo -e "\n\t${PINK}source $ZDOTDIR/aliases.zsh erfolgreich!${RESET}\n" \
		|| echo -e "\n\t${GELB}source $ZDOTDIR/aliases.zsh   ---NICHT---  erfolgreich!${RESET}\n"'
alias Zalias='ZALI'
alias Zfunc='micro "$ZDOTDIR/functions/my-functions.zsh" \
			&& source "$ZDOTDIR/functions/my-functions.zsh"'
			#			&& echo -e "\n\t${PINK}source $ZDOTDIR/zfunctions.zsh  erfolgreich!${RESET}\n" \
			# || echo -e "\n\t${GELB}source $ZDOTDIR/zfunctions.zsh   ---NICHT---  erfolgreich!${RESET}\n"'

alias Zcopy='echo -e "\n" 	\
		&& cp --verbose "$ZDOTDIR/.zshrc" "/share/bkp/zsh/$(date +'%F').nix.zshrc.zsh" \
		&& cp --verbose "$HOME/.zshenv" "/share/bkp/zsh/$(date +'%F').nix.zshenv.zsh" \
		&& cp --verbose "$ZDOTDIR/aliases.zsh" "/share/bkp/zsh/$(date +'%F')nix.aliases.zsh"'

alias Zopt=setopt
# alias wh_fuck='dpkg -L' # alle Dateien finden, die mit 'apt install' installiert wurde
#	_____________________________________________kitty_______________________

alias KITTYconf='micro -filetype zsh $XDG_CONFIG_HOME/kitty/kitty.conf'
alias Kconf=KITTYconf
alias KITTYmap='batNOcomment $KITTY_CONFIG_DIRECTORY/kitty.conf | grep "map"'
alias Kmap=KITTYmap
#	____________________________________________________________________
# alias mdtohtml='pandoc $1 -s --to html --css=$HOME/.templates/cyberpunk-DM.css | w3m -T text/html'
# alias mdtopdf='pandoc $1 -o ${1%.md}.pdf --template=$HOME/.templates/MDtoPDF.tex'


alias COL='terminal-colors -n \
			&& echo -e "${GREEN}\n...für Hex-Codes der Farben:${RED}%${LILA} \
			erminal-colors -l ${RESET}\n"'

alias Col='for i in {0..255};
 				do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " \
 				 ${${(M)$((i%6)):#3}:+$'\n'};
 		   done'
alias mangconf='micro -filetype bash $XDG_CONFIG_HOME/MangoHud/MangoHud.conf'
alias mango='mangohud glxgears &'

alias nvidia-settings='nvidia-settings --config=$XDG_CONFIG_HOME/nvidia-settings-rc'
#vidia-settings --config=~/.config/nvidia-settings-rc
#alias NIXtrash = 'nix-collect-garbage -d --delete-older-than 14d'

#alias 1SCR='zsh -c $XDG_CONFIG_HOME/scrnlayout/1.sh'
#alias 2SCR='zsh -c $XDG_CONFIG_HOME/screenlayout/2.sh'
#alias 3SCR='zsh -c $XDG_CONFIG_HOME/screenlayout/3.sh'
alias untar='tar -xvjf'
alias hack='hackertyper'
#	_______________________________neofetch_______________________________

alias neo='echo -e "\t${PINK} neofetch w/ ${LILA} \t $ZDOTDIR/neofetch/spaceinv.conf\t${RESET}" && neofetch --config $ZDOTDIR/neofetch/spaceinv.conf'
alias neo0='neo'
alias neo1='echo -e "\t  ${PINK}neofetch w/ ${LILA} \t 	$ZDOTDIR/neofetch/neofetch-short.conf\t${RESET}" && neofetch --config $ZDOTDIR/neofetch/neofetch-short.conf'
alias neo2='echo -e "\t${PINK} neofetch w/ ${LILA} \t	$ZDOTDIR/neofetch/config2.conf\t${RESET}" && neofetch --config $ZDOTDIR/neofetch/config2.conf'
alias neo3='echo -e "\t${LIME}   -  󱚡  --   --  🙼 🙼 🙼      󱢇     🙽 🙽 🙽   --    --  󱚡  --    -" && echo -e "\t${PINK}  neofetch w/ ${LILA} \t	$ZDOTDIR/neofetch/neofetch-long.conf\t${RESET}" && echo -e "\t${CYAN}   -  󱚡  --   --  🙼 🙼 🙼   󱢇     󱢇  🙽 🙽 🙽   --    --  󱚡  --    -" &&  neofetch --config $ZDOTDIR/neofetch/neofetch-long.conf'	
alias neo4='echo -e "\t${PINK} neofetch w/ ${LILA} \t  a for loop of themes	/home/project/neofetch-themes${RESET}" && bash -c /home/project/neofetch-themes/for-loop.sh'							
# 	 	  \

#	____________________________________________________________________
#alias sudo='sudo --preserve-env=HOME'

alias diff='echo -e "\t${GREEN}"colordiff w/ --ignore-case --ignore-tab-expansion --ignore-trailing-space --ignore-space-change --ignore-all-space --ignore-blank-line" && 	 colordiff --ignore-case           --ignore-tab-expansion    --ignore-trailing-space --ignore-space-change   --ignore-all-space      --ignore-blank-lines'

alias LSblk='echo -e "\t${GREEN}enhanced lsblk .. als Tabelle mit --merge --zoned --ascii --topology ${RESET}" && /
		lsblk 	--width 80 --merge --zoned      /
				--ascii --topology --output     /
				MODEL,MOUNTPOINTS,PATH,SIZE,TRAN,LABEL,FSTYPE,TYPE'

alias LSmod='echo -e "\t${GREEN}enhanced ls mod w/ Kernel-Modul -Name and -description ${RESET}"  && while IFS= read -r name; do printf "%s\t\t%s\n" "${name}" "$(sudo modinfo "$name" | grep "description" | cut -c17-)"; done <<< "$(lsmod | cut -d " " -f1 | tail -n +2)"'
#	____________________________________________________________________

alias Mconf='micro $MICRO_CONFIG_HOME/settings.json'
alias Mbind='micro $MICRO_CONFIG_HOME/bindings.json'
#	____________________________________________________________________
alias TREE2='echo -e "\t${GREEN}cmd tree --level 2"  && tree -L 2 -s -h -F -C -a --du --prune $(pwd)'
alias TREE4='echo -e "\t${GREEN}cmd tree --level 4 " && tree -L 4 -s -h -F -C -a --du --prune $(pwd)'
alias TREE8='echo -e "\t${GREEN}cmd tree --level 8"  && tree -L 8 -s -h -F -C -a --du --prune $(pwd)'

# Terminal linker Screen, NordEast, 2x
#alias Tl2x='gnome-terminal --geometry 70x26+387+514; gnome-terminal --geometry 70x26+387+4'
# Terminal rechter Screen, Nord, 2x
#alias Tr2x='gnome-terminal --geometry 79x21+1694+768; gnome-terminal --geometry 79x17+1692+1147'

#	______________________________________________________espeak-ng______________
alias Vtime='espeak-ng -v mb-de5 -s 135 -p 15 -g 10 -k 10 -b 1 \
				"Es ist jetzt $(date "+%R"). Heute ist $(date "+%A")."'

alias Vdate='espeak-ng -v mb-de5 -s 135 -p 15 -g 10 -k 10 -b 1 						\
			"Heute ist $(date "+%A")! Wir haben den $(date "+%d")ten $(date "+%B"). \
			Wir sind im Jahre $(date "+%Y") nach neuer Zeitrechnung." '
#	_________________________________________________________xwininfo___________
##     gnome gui windows ##
alias WMinfo='echo -e "
	\n\t${PINK}...2xklicken! mittels${GELB} cmd xprop und xwininfo${PINK}, zeigt Parameter des Windows an!${RESET}\n" && \
	xprop | grep --color=auto -E WM_CLASS  && \
	xwininfo | grep --color=auto geometry'

alias WMverbose='echo -e "
	\n\t${PINK}\n 2xklicken! mittels${GELB} cmd xprop und xwininfo${PINK}... zeigt Parameter des Windows an!${RESET}\n" && \
	xprop | grep --color=auto -e "WM_CLASS(STRING)" -e "*SIZE*" -e "WM_PROTOCOLS(ATOM):" -e "geometry" -e "_NET_WM_ALLOWED_ACTIONS(ATOM)" && \
	 xwininfo | grep --color=auto geometry'
#	____________________________________________________________________
#	____________________________________________________________________
alias Find='echo -e "
	${PINK} for 	files \t\t% fd -tf
	${LILA} for  	executable files\t \t % fd -tx
	${PINK} for	empty files\t % fd --type empty --type file
	${LILA} 	same as	\t\t% fd  -te 		   -tf
	${PINK} for   empty directories:	\t	% fd --type empty --type directory  ${LILA}  same same    % fd  -te  -Td"  \n  \
	&& fd'

alias nano=micro
alias edit=micro
alias DATE='echo -e "\t${PINK}Zeige das aktuelle Datum  $(date "+%A, %-d. %B %Y"):{$RESET}" && echo -e "${GELB} $(date "+%A, %-d. %B %Y")${RESET} \n "&& echo -e "${PINK} oder $ (date +%F_%H-%M)\t ${RESET}" 	&& echo -e "${GELB} $(date "+%F_%H-%M") ${RESET}"'

alias CHmod='find . -maxdepth 1 -type f \( -name "*.sh" -o -name "*.zsh" \) -exec chmod --verbose u+x {} +'

alias debug='echo "Debugging..."; set -x'

alias LOG='cat "$ZDOTDIR/log_error/log_error.txt" | grep "error" | sort'
alias LOGseparate='tail -f "$ZDOTDIR/log_error/log_error.txt"'
alias LOGinline='less -F "$ZDOTDIR/log_error/log_error.txt"'
# #... grep ... in History auf WORD
alias h='history'
# ODER:  alias history='history -E' # -E ... europe-timefmt
alias history='history -t "%H:%MUhr am %d.%b: "'
# ODER: alias history='history -t "%d. %b %Y %H:%M Uhr"'
alias g2history='cat "$HISTFILE" | grep -i --colour=always'
alias g2h=g2history
alias h2g=g2history

#grep...auf [ENV] printable enviroment variable auf WORD
alias g2env='printenv | grep -i --colour=always'
alias env2g='g2env'
#... grep ... in printable aliases auf WORDnc
alias g2ali='alias | grep -i --colour=always'
alias ali2g='g2ali'
alias g2lol='g2ali'
alias lol2g='g2ali'
#	________________________________________________cat / batcat____________________

# über config-file
alias BATconf='edit /share/bat/config.toml'
alias Bconf='BATconf'
alias bap='bat -p'
alias bat='bat6'
# gute themes für batcat:       ansi, OneHalfDark, Dracula, Coldark-Dark
alias bat1='bat 	--wrap=auto 	--plain 	--terminal-width 76   	--theme=ansi'
alias bat2='bat 	--wrap=auto 	--plain 	--terminal-width 80 	--theme=Dracula'
alias bat3='bat 	--wrap=auto  				--decorations=always 	--theme=Coldark-Dark'
alias bat4='bat 	--wrap=auto 	--number 	--decorations=always 	--theme=OneHalfDark'
alias bat5='bat 	--wrap=never 	--number 	--decorations=always 	--theme=base16'
alias bat6='bat 	--wrap=auto  	--decorations=always 	--theme=gruvbox-dark'
# ALT: alias batc='egrep -v "(^\s*$|^#)" $1 | bat -'
# ____________________________________________________________


#        du - estimate file space usage
# alias DU='echo -e "\t${PINK}Zeige die 22 größten Verzeichnisse und Dateien${RESET}\n" && command du -cah --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc' | sort -hr | head -n 22'
D3() {
 echo -e "\n\t${GELB} du --max-depth=3 --separate-dirs --threshold=16K -BM -x $(pwd) 2> /dev/null | sort -hr | head -n 24 ${LILA} \t... wir reden über Pfad $(pwd)${RESET}}\n"
du --human-readable --max-depth=3 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc' $pwd 2> /dev/null | sort -hr | head -n 24 
}

D1() {
 echo -e "\n\t${GREEN} du --max-depth=1 --separate-dirs --threshold=16K -BM -x \n$(pwd) 2> /dev/null | sort -hr | head -n 24 "
 echo " ${LILA} \t\n... wir reden über Pfad $(pwd)${RESET}\n"
du --human-readable --max-depth=1 --separate-dirs --threshold=16K --block-size=M --one-file-system --exclude='*cache' --exclude='*run' --exclude='*sys' --exclude='*proc' $pwd 2> /dev/null | sort -hr | head -n 24 
}
#	____________________________________________________________________________________
#gtk-update-icon-cache
#	____________________________________________________________________________________
#       e x a / e z a .. ls  ll  lh  ld ...
alias e-hugo='eza --no-git --total-size  --git-ignore -A -tree'
alias e1='echo -e "\t${GELB} eza --tree -level 1 ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --color-scale 	--no-time --no-permissions --width 76 \
	 	 --tree 		--level 1 --color-scale-mode gradient'

alias e2='echo -e "\t${GELB} eza --tree -level 2${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --color-scale 	--no-time --no-permissions --width 76 \
	 	 --tree 		--level 2  --color-scale-mode gradient'

alias e3='echo -e "\t${GELB} eza --tree -level 3  ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --color-scale 	--no-time --no-permissions --width 76 \
	 	 --tree 		--level 3	--color-scale-mode gradient'

alias e4='echo -e "\t${GELB} eza --tree -level 4 --git ${RESET}\n" && \
														 \
	 eza --all 			--long --group-directories-first \
	 	 --no-time --no-permissions   --width 76 \
	 	 --color-scale age --color-scale-mode gradient \
	 	 --tree 		--level 4	--git --color-scale-mode gradient'

alias eee='echo -e "\t${GELB} eza --tree -level 99 --git ${RESET}\n" && \
	 eza --all 			--long --group-directories-first \
	 	 --colour-scale all --color-scale-mode gradient	--no-time \
	 	 --no-permissions   --tree 		--level 99	--git --width 76'

alias ee='echo -e "eza  ... läuft"  && \
	eza --git  --almost-all --long --group-directories-first \
		 	 --colour-scale all --color-scale-mode gradient ' #	--no-time \
	#	 	 --no-permissions --git --width 76'

	#	eza --grid --long --no-permissions \
	#		 --no-time \
	#		--almost-all --header \
	#		--colour-scale all --color-scale-mode gradient'

alias e='echo -e "eza  ... pure" && \
			eza --group-directories-first --git --width 76'

alias lf='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} - Files only (hidden and non-hidden)files:${RESET}" && \\
 		eza 	--grid 		 --no-permissions --long \
 				--total-size --almost-all 	  --no-time \
 				--color-scale age --color-scale-mode gradient \
 				--classify --header --only-files --width 76'

alias ld='echo -e "\t${PINK} eza ${GELB}$(pwd)${PINK} only (hidden and non-hidden)directorys:${RESET}\n" && \
 		eza 	--grid 		 --no-permissions --long \
 				--total-size --almost-all 	  --no-time \
 				--color-scale age --color-scale-mode gradient \
 				--classify --header --only-dirs --width 76'

alias lp='eza --octal-permissions --git -Al --git-repos --no-permissions --time-style=relative --group-directories-first --smart-group'
#------------------------------------------------------------------  eza ende

alias l='
  echo -e "\t${PINK} LSD ohne alles ${RESET}\n" && \
  lsd \
    --classify \
    --group-dirs=first '

alias la='
  echo -e "\t${PINK} Zeigt alles in ${GELB}$(pwd)\n${PINK} (hidden) Files und (hidden)directory:${RESET}\n" && \
  lsd \
    --size short \
    --human-readable \
    --group-dirs=none \
    --almost-all \
    --classify '

alias ll='
  echo -e "\t${PINK} LSD ${LILA} REVERSE ... mit  alles  ${GELB}in $(pwd)\n${PINK}(mitrelativer Zeit ohne Gruppenberechtigung): ${RESET}\t" && \
  lsd   --almost-all     	--total-size \
    	--classify     		--group-dirs=first \
    	--date "relative"   --no-symlink \
    	--hyperlink 'always'    --long \
    	--size short \
    	--header \
    --blocks 'size' \
    --blocks 'links' \
    --blocks 'name' \
    --blocks 'user' \
    --blocks 'date' '

alias lll='
  echo -e "\t${PINK} LSD ${LILA}  ... mit  alles  ${GELB}in $(pwd)\n${PINK} (mit absoluter Zeit und Gruppenberechtigung): ${RESET}\t" && \
  lsd \
    --almost-all \
    --total-size \
    --date "+%d. %b %Y %H:%M Uhr" \
    --classify \
    --group-dirs 'first' \
    --no-symlink \
    --hyperlink 'always' \
    --long \
    --size short \
    --header \
    --blocks 'permission' \
    --blocks 'size' \
    --blocks 'links' \
    --blocks 'name' \
    --blocks 'user' \
    --blocks 'group' \
    --blocks 'date' '

alias lt='
  echo -e "\t${PINK} LSD ${LILA}...mit alles ${GELB}in $(pwd)${PINK} --reverse --time-sort: ${RESET} \t" && \
  lsd \
   --almost-all \
   --total-size \
   --date "+%d. %b %Y %H:%M Uhr" \
   --classify \
   --group-dirs 'first' \
   --no-symlink \
   --hyperlink 'always' \
   --long \
   --size 'short' \
   --header \
   --reverse \
   --header \
   --blocks 'size' \
   --blocks 'links' \
   --blocks 'name' \
   --blocks 'date' \
   --timesort '

alias lx='
  echo -e "\t${PINK} LSD ${LILA}...mit  alles  \
        ${GELB}in $(pwd)${PINK}--reverse --extension-sort: ${RESET}\t" && \
  lsd \
    --almost-all \
    --total-size \
    --classify \
    --group-dirs 'first' \
    --date 'relative' \
    --no-symlink \
    --hyperlink 'always' \
    --long \
    --size 'short' \
    --reverse \
    --header \
    --blocks 'size' \
    --blocks 'links' \
    --blocks 'name' \
    --blocks 'user' \
    --blocks 'date' \
    --extensionsort  '

alias ..='cd ..'

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
# make DIR
mcd () {
	echo -e "\t${PINK} Verzeichnis${GREEN} $1 ist angelegt!${RESET}\n"
    mkdir -p $1
    cd $1
	}

# Häufige Tipfehler
alias cd..='echo -e "\t${PINK}Gehe ein Verzeichnis höher${RESET}\n" && cd ..'

#alias rm='echo -e "\t${PINK}Entferne Dateien/Verzeichnisse (bestätigt)${RESET}\n" && rm --verbose --recursive -i'
#alias cp --verbose='echo -e "\t${PINK}Kopiere Dateien/Verzeichnisse cp --verbose -ivr(bestätigt)${RESET}\n" && cp --verbose --verbose --recursive --interactive'
#alias mv='echo -e "\t${PINK}Verschiebe/umbenenne Dateien/Verzeichnisse (interacive, verbose)${RESET}\n" && mv -v -i'
#alias alais='echo -e "\t${PINK}Alias für Alias${RESET}\n" && alias'
#alias _='echo -e "\t${PINK}Führe als Superuser (sudo) aus${RESET}\n" && sudo'

alias c='clear; neo0'
alias q='echo -e "\t${PINK}Beenden${RESET}\n" && exit'
alias lol='alias | sort -k1,1 -k1.1,1.2 -k1.3,1.4| clolcat; echo -e "\n${GREEN}... das sind die aktuellen aliase, alphabetisch sortiert ${RESET}\n"'

#	________________________________________________________________________________
alias GIT='echo -e "\t${PINK}git aliase aus Zeile 480 bis 556\t $ZDOTDIR/aliases.zsh  ${RESET}\n" && \
		   bat  --wrap=auto			 --decorations=always \
		   		--theme=Coldark-Dark --line-range=480:556 $ZDOTDIR/aliases.zsh'

#	_________________________________________font: univers_______________________
#
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

alias gsss='echo -e "${PINK}\n\t git status --short ${RESET} with abbr.:${RESET}\n
${GELB}?? ... Untracked files${RESET}\t${GELB}U ... Files with merge conflicts${RESET}\t ${GELB}A ... New files added to staging ${RESET}\t${GELB}M ... Modified files${RESET}\t${GELB}D ... Deleted files${RESET}\t${GELB}R ... Renamed files${RESET}\t${GELB}C ... Copied files${RESET}\n" && git status -s'
alias gss='cowsay -W 34 \
"${NIGHT}     git status -s crypt:       -
 1st row: NOT- & 2nd row: -STAGED-
${PINK} ---------------------------------
   ...M for  modified          -
   ...A for new and staged     -
   ...C for copied             -
   ...R for renamed            - ${NIGHT} " && git status -s'

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

#	_______GIT - AUSGABE ENDE   li:455-530___________________________________________
#	_____________________________________________________
 #	 ┌─┐┬  ┌─┐┌┐ ┌─┐┬  ┌─┐  ┌─┐┌─┐┬ ┬  ┌─┐┬  ┬┌─┐┌─┐┌─┐
 #	 │ ┬│  │ │├┴┐├─┤│  ├┤   ┌─┘└─┐├─┤  ├─┤│  │├─┤└─┐├┤
 #	 └─┘┴─┘└─┘└─┘┴ ┴┴─┘└─┘  └─┘└─┘┴ ┴  ┴ ┴┴─┘┴┴ ┴└─┘└─┘
 # 	  usage% file G 'pattern'
 ### ---------------------------  ####
 # alias -g OK='~/zsh/testbed.zsh'

alias -g REC='asciinema rec --idle-time-limit=2 --overwrite --title'

 alias -g ED='	 gnome-text-editor 	--ignore-session 	--standalone 	--new-window  &'
 alias -g gedit='gnome-text-editor 	--ignore-session  	--standalone 	--new-window &'
 alias -g cmd='command'
 alias -g SRC='source'
 alias -g L='  |  less'
 alias -g LL=' | less -X -j5 --tilde --save-marks \
 				--incsearch --RAW-CONTROL-CHARS   \
 				--LINE-NUMBERS --line-num-width=3 \
 				--quit-if-one-screen --use-color  \
 				--color=NWr --color=EwR  --color=PbC --color=Swb'

 alias -g G='|grep --ignore-case --color=auto'
 alias -g HG='--help 2>&1 | grep'
 alias -g H='--help'

 alias -g N0='2> /dev/null'
 alias -g D0='2> /dev/null'

 alias fgrep='fgrep --color=auto'
 alias  egrep='egrep --color=auto'

### ---------------------------  ####
#        ┌─┐┬ ┬┌─┐┌─┐┬─┐ ┬
#        └─┐│ │├┤ ├┤ │┌┴┬┘
#        └─┘└─┘└  └  ┴┴ └─
# ┌─┐┌─┐┬ ┬  ┌─┐┬  ┬┌─┐┌─┐┌─┐
# ┌─┘└─┐├─┤  ├─┤│  │├─┤└─┐├┤
# └─┘└─┘┴ ┴  ┴ ┴┴─┘┴┴ ┴└─┘└─┘
### ---------------------------  ####
alias -s mp4='vlc --fullscreen 	--no-video-title-show --no-video-menu	--no-video-border'
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm,opus,flac}='vlc'
alias -s {jpg,jpeg,png,bmp,svg,gif,webp}='kitty +kitten icat'
alias -s md='typora' # --preview #--display
alias -s {js,json,env,html,css,toml}='bat0|bat|cat'
#alias -s {bash,zsh,csh,txt}='micro'
alias -s {conf}='micro -filetype bash'
alias -s {nix}='gnome-text-editor'
alias -s {txt}='micro -filetype bash'
alias -s {pdf,otf,xls}='xreader -w'  #TODO: andere Formate ergänzen

alias -s html='firefox'  #TODO: andere Formate ergänzen
#alias -s py = python
#alias -s log = less
# "Run" ssh links to clone repos
# % git@github.com:stefanjudis/dotfiles.git # wird zu
# % git clone git@github.com:stefanjudis/dotfiles.git
# alias -s git="git clone"

################################################################

# -->greeting.zsh aliases.zsh
# export SCRIPT_RUN_aliaseszsh="true"
