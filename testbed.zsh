#!/usr/bin/env zsh

# Farbcodes definieren für die Ausgabe im Terminal
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
GELB="\033[38;2;232;197;54m\033[48;2;128;87;0m"

# Funktion zum Anzeigen des letzten ausgeführten Befehls
last_command() {
    # `fc -n -l -1 -1` gibt den letzten ausgeführten Befehl zurück
    last_cmd=$(fc -n -l -1 -1)
    echo -e "${GREEN}Letzter Befehl: $last_cmd"
}

# Hauptfunktion zur Abrufung von Informationen über einen gegebenen Befehl
command_info() {
    local cmd=$1
    local info=""

    # Versuch, tldr-Pages für den Befehl zu finden
    tldr_output=$(tldr $cmd 2>&1)
    if [ $? -eq 0 ]; then
        echo -e -n "${GREEN}tldr"; sleep 0.6; echo -e -n "... Eintrag: "; sleep 0.6; echo -e "gefunden" # Korrigierte Zeile
        info="$tldr_output"
    else
        echo -e "${RED}Fehler beim Abrufen von tldr Informationen für $cmd"
        return 1
    fi

    # Falls tldr keine Informationen liefert, versuche mit cheat
    if [ -z "$info" ]; then
        cheat_output=$(cheat $cmd 2>&1)
        if [ $? -eq 0 ]; then
            info="$cheat_output"
            echo -e "${GREEN}cheat Ausgabe: $cheat_output"
            sleep 1
        else
            echo -e "${RED}Fehler beim Abrufen von cheat Informationen für $cmd"
            return 1
        fi
    fi
    
    # Falls cheat keine Informationen liefert, versuche mit man
    if [ -z "$info" ]; then
        man_output=$(man $cmd 2>&1)
        if [ $? -eq 0 ]; then
            info="$man_output"
            echo -e "${GREEN}man Ausgabe: $man_output"
            sleep 1
        else
            echo -e "${RED}Fehler beim Abrufen von man Informationen für $cmd"
            return 1
        fi
    fi

    # Falls man keine Informationen liefert, versuche mit --help und --usage
    if [ -z "$info" ]; then
        help_output=$($cmd --help 2>&1)
        if [ $? -eq 0 ]; then
            info="$help_output"
            echo -e "${GREEN}--help Ausgabe: $help_output"
            sleep 1
        else
            usage_output=$($cmd --usage 2>&1)
            if [ $? -eq 0 ]; then
                info="$usage_output"
                echo -e "${GREEN}--usage Ausgabe: $usage_output"
                sleep 1
            else
                echo -e "${RED}Fehler beim Abrufen von --help oder --usage Informationen für $cmd"
                return 1
            fi
        fi
    fi

    echo "$info"
}

