#!/usr/bin/env bash

# Originalautor: max_kempter
# Dateiname: was.sh
# Verwendung: ./was.sh [BEFEHL]
# Zweck: Sammelt Informationen über einen Befehl mittels verschiedener Tools
#        (tldr, cheat, man, navi) und zeigt sie strukturiert an

# Farbdefinitionen für Terminalausgabe
# Jede Farbe setzt Vordergrund- und Hintergrundfarbe mittels ANSI Escape Codes
export SKY=$(echo -e "\033[38;2;62;36;129m\033[48;2;135;206;235m")  # Himmelblau mit dunklerem Text
export RED=$(echo -e "\033[38;2;240;128;128m\033[48;2;139;0;0m")     # Rot mit dunklerem Hintergrund
export RASPBERRY=$(echo -e "\033[38;2;32;0;21m\033[48;2;221;160;221m") # Himbeerfarben
export RESET=$(echo -e "\033[0m")  # Setzt alle Formatierungen zurück

# Überprüfung erforderlicher Tools
# Die Schleife stellt sicher, dass alle benötigten Befehle verfügbar sind
for cmd in tldr cheat man navi; do
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}\tFehler: $cmd ist nicht installiert.${RESET}\n"
        exit 1
    fi
done

# Zeigt den letzten ausgeführten Befehl an
## Nutzt die Bash-Builtin-Funktion 'fc' für Command History
last_command() {
    last_cmd=$(fc -nl -1)  # -nl: Zeige ohne Line Numbers, -1: Letzter Befehl
    echo -e "${SKY}\tLetzter Befehl: $last_cmd${RESET}\n"
}

## Hauptfunktion zur Informationsbeschaffung
get_command_info() {
    local cmd="$1"
    declare -A outputs=(
        [tldr]="" 
        [cheat]="" 
        [man]=""
        [navi]=""
    )
    local options=()

# Informationen parallel sammeln
## Jedes Tool wird in einem Subshell-Prozess ausgeführt
    outputs[tldr]=$(tldr "$cmd" 2>&1) && options+=(tldr)
    outputs[cheat]=$(cheat "$cmd" 2>&1) && options+=(cheat)
    outputs[man]=$(MANWIDTH=80 man "$cmd" 2>&1 | col -bx) && options+=(man)  # col -bx entfernt Backspace-Formatierung
    outputs[navi]=$(navi --query "$cmd" 2>&1) && options+=(navi)

  # Fallback, wenn keine Informationen gefunden
    if ((${#options[@]} == 0)); then
        echo -e "${RED}\tKeine Informationen für $cmd gefunden.${RESET}\n"
        return 1
    fi
  # Interaktive Auswahl
    echo -e "${SKY}\tVerfügbare Quellen für '$cmd':${RESET}"
    PS3="${SKY}Bitte wählen (1-${#options[@]}):${RESET} "
    #PS3="$(echo -e ${SKY}Bitte wählen (1-${#options[@]}):${RESET}) "
    select selected_option in "${options[@]}"; do
        [[ -n "$selected_option" ]] && break
        echo -e "${RED}Ungültige Auswahl. Bitte 1-${#options[@]} eingeben.${RESET}"
    done
  # Ausgabeformattierung
    case "$selected_option" in
        tldr|cheat|navi)
            echo -e "${RASPBERRY}=== $selected_option ===${RESET}\n${outputs[$selected_option]}\n"
            ;;
        man)  # Man-Ausgabe mit Highlighting
            echo -e "${RASPBERRY}=== MAN-PAGE (gekürzt) ===${RESET}"
            echo "${outputs[man]}" | head -n 30 | highlight -O ansi -S sh
            ;;
    esac
}

# Skript-Hauptablauf
if (($# == 0)); then
    last_command  # Zeige letzten Befehl bei fehlendem Argument
else
    get_command_info "$1"
fi
