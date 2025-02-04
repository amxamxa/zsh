#!/usr/bin/env zsh

# Farbcodes definieren für die Ausgabe im Terminal
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
YELLOW="\033[38;2;232;197;54m\033[48;2;128;87;0m"

# Funktion zum Anzeigen des letzten ausgeführten Befehls
last_command() {
    last_cmd=$(fc -n -l -1 -1)
    echo -e "${GREEN}Letzter Befehl: $last_cmd"
}

# Funktion zur Informationsbeschaffung über einen Befehl
get_command_info() {
    local cmd=$1
    local info=""

    tldr_output=$(tldr $cmd 2>&1)
    if [ $? -eq 0 ]; then
        info="$tldr_output"
        echo -e "${GREEN}tldr Ausgabe: $tldr_output"
    else
        echo -e "${RED}Fehler beim Abrufen von tldr Informationen für $cmd"
    fi

    if [ -z "$info" ]; then
        cheat_output=$(cheat $cmd 2>&1)
        if [ $? -eq 0 ]; then
            info="$cheat_output"
            echo -e "${GREEN}cheat Ausgabe: $cheat_output"
        else
            echo -e "${RED}Fehler beim Abrufen von cheat Informationen für $cmd"
        fi
    fi

    if [ -z "$info" ]; then
        man_output=$(man $cmd 2>&1)
        if [ $? -eq 0 ]; then
            info="$man_output"
            echo -e "${GREEN}man Ausgabe: $man_output"
        else
            echo -e "${RED}Fehler beim Abrufen von man Informationen für $cmd"
        fi
    fi

    if [ -z "$info" ]; then
        help_output=$($cmd --help 2>&1)
        if [ $? -eq 0 ]; then
            info="$help_output"
            echo -e "${GREEN}--help Ausgabe: $help_output"
        else
            usage_output=$($cmd --usage 2>&1)
            if [ $? -eq 0 ]; then
                info="$usage_output"
                echo -e "${GREEN}--usage Ausgabe: $usage_output"
            else
                echo -e "${RED}Fehler beim Abrufen von --help oder --usage Informationen für $cmd"
            fi
        fi
    fi

    echo "$info"
}

# Hauptlogik des Skripts
if [ $# -eq 0 ]; then
    last_command
else
    get_command_info $1
fi
