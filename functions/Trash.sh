#!/usr/bin/env bash

local DIR = "$HOME/.local/share/Trash"

TRASH() {
    if [ -d "$DIR" ]; then
eza -Al "$DIR" || ls -Al "$DIR"
        printf "${GELB}Sind Sie sicher, dass Sie alle Dateien im Trash löschen möchten? (j/n):${RESET} "
        read answer
        case $answer in
            [Jj]* )
                command rm --recursive --one-file-system --force $HOME/.local/share/Trash/*
                echo -e "${GREEN}Alles gelöscht.${RESET}"
                ;;
            * )
                echo -e "${YELLOW}Aktion abgebrochen.${RESET}"
                ;;
        esac
    else
        echo -e "${YELLOW}Trash-Verzeichnis existiert nicht.${RESET}"
    fi
}


