#!/usr/bin/env bash

# Generate a m3u files with same filename as directories passed as arguments.
# The file is written with all files in each arg.
# HOWTO: 
# genPlaylist.sh .# genPlaylist.sh Kiz/
# this  creates a file 'kiz.m3u'

GENplaylist() {
    for file in "$@"
    do
        if [ -d $file ]; then
            m3u="$file.m3u"
            find "$file" -type f > "$m3u"
        else
            echo "'$file' should be the direc
tory where all your files are"
        fi
    done
            }
            #_________________________

NETport() {
# List of port opens, fuzzy searchable via fzf
     sudo netstat -tulpn | grep LISTEN | fzf;
        }
#	______________

