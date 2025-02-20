#!/usr/bin/env bash

# auth: max_kempter
# filename: was.sh
# howto: ./was.sh lsd
# Aufgaben des Skripts:
#   Dieses Skript dient dazu, Informationen über einen 
#   bestimmten Befehl zu sammeln und anzuzeigen.
#   Es verwendet verschiedene Tools wie tldr, cheat, man, 
#   und navi, um Informationen zu beschaffen.
# Anleitung zur Nutzung:
#   Führen Sie das Skript mit einem Befehl als Argument 
#   aus, z.B. ./was.sh lsd, um Informationen über den Befehl "lsd" zu erhalten.

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
    echo -e "${SKY}\tLetzter Befehl: $last_cmd${RESET}\n"
}

# Funktion zur Informationsbeschaffung über einen Befehl
get_command_info() {
    local cmd="$1"
    local tldr_output=""
    local cheat_output=""
    local man_output=""
    local options=()

    # tldr ausführen
    tldr_output=$(tldr "$cmd" 2>&1)
    if [[ $? -eq 0 ]]; then
        options+=("tldr")
    fi

    # cheat ausführen
    cheat_output=$(cheat "$cmd" 2>&1)
    if [[ $? -eq 0 ]]; then
        options+=("cheat")
    fi

    # man ausführen
    man_output=$(man "$cmd" 2>&1)
    if [[ $? -eq 0 ]]; then
        options+=("man")
    fi

# Wenn keine Optionen verfügbar sind, Fehler ausgeben
    if [[ ${#options[@]} -eq 0 ]]; then
        echo -e "${RED}\tKeine Informationen für $cmd gefunden.${RESET}\n"
        return
    fi

# Verfügbare Optionen anzeigen
    echo -e "${SKY}\tVerfügbare Informationsquellen für '$cmd':${RESET}"
    for i in "${!options[@]}"; do
        echo -e "${SKY}\t$((i+1)). ${options[$i]}${RESET}"
    done

# Benutzerauswahl
    echo -e "${SKY}\tBitte wählen Sie eine Option (1-${#options[@]}):${RESET}"
    read -r choice

 # Auswahl validieren und entsprechende Ausgabe anzeigen
    if [[ $choice -ge 1 && $choice -le ${#options[@]} ]]; then
        selected_option="${options[$((choice-1))]}"
        case "$selected_option" in
            "tldr")
                echo -e "${SKY}\ttldr Ausgabe: $tldr_output${RESET}\n"
                ;;
            "cheat")
                echo -e "${SKY}\tcheat Ausgabe: $cheat_output${RESET}\n"
                ;;
            "man")
                echo -e "${SKY}\tman Ausgabe: $man_output${RESET}\n"
                ;;
        esac
    else
        echo -e "${RED}\tUngültige Auswahl.${RESET}\n"
    fi
}

# Hauptlogik des Skripts
if [[ $# -eq 0 ]]; then
    last_command
else
    get_command_info "$1"
fi
