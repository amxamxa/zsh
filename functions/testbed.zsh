#!/usr/bin/env zsh

# Farbcodes definieren für die Ausgabe im Terminal
# Grün für erfolgreiche Ausgaben
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
# Rot für Fehlermeldungen
RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
# Gelb (nicht verwendet, könnte für Warnungen oder Hinweise genutzt werden)
YELLOW="\033[38;2;232;197;54m\033[48;2;128;87;0m"

# Funktion zum Anzeigen des letzten ausgeführten Befehls
last_command() {
    # `fc -n -l -1 -1` gibt den letzten ausgeführten Befehl zurück
    last_cmd=$(fc -n -l -1 -1)
    # Ausgabe des letzten Befehls in grüner Farbe
    echo -e "${GREEN}Letzter Befehl: $last_cmd"
}

# Funktion zur Informationsbeschaffung über einen Befehl
get_command_info() {
    local cmd=$1
    local info=""

    # Versuche, Informationen mit tldr abzurufen
    tldr_output=$(tldr $cmd 2>&1)
    if [ $? -eq 0 ]; then
        info="$tldr_output"
        echo -e "${GREEN}tldr Ausgabe: $tldr_output"
        sleep 1
    else
        echo -e "${RED}Fehler beim Abrufen von tldr Informationen für $cmd"
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
        fi
    fi

    # Falls man keine Informationen liefert, versuche mit --help
    if [ -z "$info" ]; then
        help_output=$($cmd --help 2>&1)
        if [ $? -eq 0 ]; then
            info="$help_output"
            echo -e "${GREEN}--help Ausgabe: $help_output"
            sleep 1
        else
            # Falls --help keine Informationen liefert, versuche mit --usage
            usage_output=$($cmd --usage 2>&1)
            if [ $? -eq 0 ]; then
                info="$usage_output"
                echo -e "${GREEN}--usage Ausgabe: $usage_output"
                sleep 1
            else
                echo -e "${RED}Fehler beim Abrufen von --help oder --usage Informationen für $cmd"
            fi
        fi
    fi

    # Ausgabe der gesammelten Informationen
    echo "$info"
}

# Beispielaufruf der Funktion
# info last_command
# info get_command_info ls

# Benutzungsanweisung
# Dieses Skript dient dazu, Informationen über einen gegebenen Befehl abzurufen.
# Es versucht nacheinander, Informationen von tldr, cheat, man, --help und --usage zu erhalten.
# Falls ein Befehl gefunden wird, wird dessen Information ausgegeben.

# Beispiele:
# Abrufen von Informationen über einen bestimmten Befehl:
# ./testbed.zsh command_info ls
