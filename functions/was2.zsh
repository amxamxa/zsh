#!/usr/bin/env bash

# Header
# auth: max_kempter
# filename: was.sh
# howto: ./was.sh lsd
# Erklärung Aufgaben des Skripts:
# Dieses Skript dient dazu, Informationen über einen bestimmten Befehl zu sammeln und anzuzeigen.
# Es verwendet verschiedene Tools wie tldr, cheat, man, und navi, um Informationen zu beschaffen.
# Anleitung zur Nutzung:
# Führen Sie das Skript mit einem Befehl als Argument aus, z.B. ./was.sh lsd, um Informationen über den Befehl "lsd" zu erhalten.

# Farbcodes definieren für die Ausgabe im Terminal
export SKY=$(echo -e "\033[38;2;62;36;129m\033[48;2;135;206;235m")
export RED=$(echo -e "\033[38;2;240;128;128m\033[48;2;139;0;0m")
export RASPBERRY=$(echo -e "\033[38;2;32;0;21m\033[48;2;221;160;221m")
export RESET=$(echo -e "\033[0m")

# Prüfen, ob die benötigten Info-Apps installiert sind
for cmd in tldr cheat man navi; do
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}\tFehler: $cmd ist nicht installiert.${RESET}\n"
        exit 1
    fi
done

# Funktion zum Anzeigen des letzten ausgeführten Befehls
last_command() {
    last_cmd=$(fc -nl -1)
    echo -e "${SKY}\tLetzter Befehl:${RESET}\n $last_cmd"
}
# Funktion zur Informationsbeschaffung über einen Befehl
get_command_info() {
    local cmd="$1"
    local info=""
    local tldr_output=""
    local cheat_output=""
    local man_output=""

# cheat zuerst ausführen
    cheat_output=$(cheat "$cmd" 2>&1)
    if [[ $? -eq 0 ]]; then
        info="$cheat_output"
        echo -e "${SKY}\tcheat Ausgabe: ${RESET}\n $cheat_output"
    else
        echo -e "${RED}\tFehler beim Abrufen von cheat Informationen für ${RESET} $cmd\n"
    fi

# tldr nur ausführen, wenn cheat kein Ergebnis liefert
    if [[ -z "$info" ]]; then
        tldr_output=$(tldr "$cmd" 2>&1)
        if [[ $? -eq 0 ]]; then
            info="$tldr_output"
            echo -e "${SKY}\ttldr Ausgabe:${RESET}$tldr_output\n"
        else
            echo -e "${RED}\tFehler beim Abrufen von tldr Informationen für${RESET}\n $cmd"
        fi
    fi

# man nur ausführen, wenn weder cheat noch tldr ein Ergebnis liefern
    if [[ -z "$info" ]]; then
        man_output=$(man "$cmd" 2>&1)
        if [[ $? -eq 0 ]]; then
            info="$man_output"
            echo -e "${SKY}\tman Ausgabe: (wird nur auf Anfrage angezeigt)${RESET}\n"
        else
            echo -e "${RED}\tFehler beim Abrufen von man Informationen für ${RESET}\n $cmd"
        fi
    fi

 # Wenn man ein Ergebnis hat, frage den Benutzer, ob er es anzeigen möchte
    if [[ -n "$man_output" ]]; then
        echo -e "${SKY}\tMöchten Sie die man-Seite anzeigen? (Drücken Sie ENTER, um fortzufahren, oder STRG+C, um abzubrechen)${RESET}"
        read -r
        echo -e "$man_output\n"
    fi

    # Wenn immer noch keine Informationen vorhanden sind, versuche --help oder --usage
    if [[ -z "$info" ]]; then
        help_output=$("$cmd" --help 2>&1)
        if [[ $? -eq 0 ]]; then
            info="$help_output"
            echo -e "${SKY}\t--help Ausgabe: $help_output${RESET}\n"
        else
            usage_output=$("$cmd" --usage 2>&1)
            if [[ $? -eq 0 ]]; then
                info="$usage_output"
                echo -e "${SKY}\t--usage Ausgabe: $usage_output${RESET}\n"
            else
                echo -e "${RED}\tFehler beim Abrufen von --help oder --usage Informationen für $cmd${RESET}\n"
            fi
        fi
    fi

    # Wenn immer noch keine Informationen vorhanden sind, versuche navi
    if [[ -z "$info" ]]; then
        navi_output=$(navi "$cmd" 2>&1)
        if [[ $? -eq 0 ]]; then
            info="$navi_output"
            echo -e "${SKY}\tnavi Ausgabe: $navi_output${RESET}\n"
        else
            echo -e "${RED}\tFehler beim Abrufen von navi Informationen für $cmd${RESET}\n"
        fi
    fi
}

# Hauptlogik des Skripts
if [[ $# -eq 0 ]]; then
    last_command
else
    get_command_info "$1"
fi
