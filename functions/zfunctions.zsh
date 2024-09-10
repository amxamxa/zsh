#!/usr/bin/env zsh 
###########################################
## ╔═╗╦╦  ╔═╗ 
## ╠╣ ║║  ║╣ name: 			zfunctions.zsh
## ╚  ╩╩═╝╚═╝  
##	 -PATH:    	/home/zsh/
##	 -STATUS:	final
##	 -USAGE:	source in .zshrc
## -------------------------------------
## FILE DATES	[yyyy-mmm-dd]
## .. SAVE:	  	2024-feb-23
## .. CREATION: tba
## -----------------------------------------
## AUTHOR:		mxx, Phantas0s
## COMMENTS: 	https://github.com/Phantas0s/.dotfiles/tree/master/zsh
###########################################

Zcomp() {
# Display all autocompleted command in zsh.
# First column: command name Second column: completion function
  for command completion in ${(kv)_comps:#-*(-|-,*)}
    do
        printf "%-32s %s\n" $command $completion
    done | sort
		}

Htop() {
# Display the command more often used in the shell
    history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head
		}

PROspeed() {
# Display the time for the prompt to appear when opening a new zsh instance
	 for i in $(seq 1 10); do /run/current-system/sw/bin/time zsh -i -c exit; done
		}

NETports() {
# List of port opens, fuzzy searchable via fzf
	 sudo netstat -tulpn | grep LISTEN | fzf;
		}



# cheat() {
# Display command cheatsheet from [cheat.sh](https://github.com/Phantas0s/.dotfiles/blob/master/zsh/cheat.sh).
    # curl cht.sh/:help
  #   curl cheat.sh/$1 
     # &style=fruity'
#styles: paraiso-dark
#		}


##############################################################################
# Generate a m3u files with same filename as directories passed as arguments.
# The file is written with all files in each arg.
# Example: cm3u KIZ,  create a file 'kiz.m3u' and inside for example 'Xenogears/Xenogears The Game.bin'
GENplaylist() {
    for file in "$@"
    do
        if [ -d $file ]; then
            m3u="$file.m3u"
            find "$file" -type f > "$m3u"
        else
            echo "'$file' should be the directory where all your files are"
        fi
    done
			}
	##############################################################################
matrix() {
    local lines=$(tput lines)
    cols=$(tput cols)

    # AWK-Skript für die Matrix-Animation mit Farben
    awkscript='
    {      letters="x_-FUCKk"
     	   lines=$1
        	random_col=$3
        	c=$4
        	letter=substr(letters,c,1)
        	cols[random_col]=0;
        	for (col in cols) {
            	line=cols[col];
            	cols[col]=cols[col]+1;
            	# Zufällige Farbauswahl für jeden Buchstaben
            	color=rand() * 6 + 31
            
            	# Ausgabe des aktuellen Buchstabens in zufälliger Farbe an der aktuellen Position
            	printf "\033[%s;%sH\033[38;5;%dm%s", line, col, color, letter;
            	# Zurücksetzen der Farbe für das nächste Zeichen
            	printf "\033[%s;%sH\033[0m%s\033[0;0H", cols[col], col, letter;
            
            		if (cols[col] >= lines) {
                	cols[col]=0;
            								}
        						}   
    }
    '

	    # Hintergrundfarbe des Terminals auf Schwarz ändern
	    echo -e "\e[1;40m"
	    # Bildschirm löschen
	    clear

	    # Endlosschleife für die Matrix-Animation
	    while :; do
	        # Generieren von vier zufälligen Werten und Ausgabe an AWK
	        echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
	        # Kurze Pause für die Animation
	        sleep 0.02
	    # AWK-Skript auf die Ausgabe anwenden, um die Matrix-Animation zu erzeugen
    done | awk "$awkscript"
}
##############################################################################
# matrix () {
#     local lines=$(tput lines)
#     cols=$(tput cols)
# 
#     awkscript='
#     {
#        letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
#        lines=$1
#        random_col=$3
#        c=$4
#        letter=substr(letters,c,1)
#        cols[random_col]=0;
#        for (col in cols) {
#            line=cols[col];
#            cols[col]=cols[col]+1;
#            printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
#            printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
#            if (cols[col] >= lines) {
#                cols[col]=0;
#             						}
#    	 	}	
# 	}
# '
# echo -e "\e[1;40m"
# clear
# 
# while :; do
#     echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
#     sleep 0.05
# done | awk "$awkscript"
# 	}
# 

