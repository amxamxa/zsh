#!/usr/bin/env bash
# Autor: max_kempter
# Dateiname: was.sh
# Version: 1.1.0
# Anwendung: ./was.sh [OPTIONEN] [BEFEHL]
# Zweck: 
#   Sammelt Informationen über Befehle mittels tldr, cheat und man
#   mit erweiterten Formatierungsoptionen und Hilfefunktionen.


# Farbcodes definieren für die Ausgabe im Terminal
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
YELLOW="\033[38;2;232;197;54m\033[48;2;128;87;0m"
BLINK="\033[5m"  	# blink	 txt 
RESET="\033[0m"

# Hilfefunktion
show_help() {
    echo -e "${WINE}was.sh - Command Documentation Explorer${RESET}"
    echo -e "Verwendung: ${WINE}./was.sh [OPTIONEN] [BEFEHL]${RESET}"
    echo -e "\nOptionen:"
    echo -e "  ${WINE}-h${RESET}    Zeige diese Hilfe"
    echo -e "  ${WINE}-v${RESET}    Zeige Versionsinformation"
    echo -e "\nBeispiele:"
    echo -e "  ${WINE}./was.sh curl${RESET}     # Info über curl"
    echo -e "  ${WINE}./was.sh -v${RESET}      # Version anzeigen"
}

# Versionsinfo
show_version() {
    echo -e "${WINE}was.sh ${RESET}| Version 1.1.0 | (c) 2023 max_kempter"
    echo -e "Dokumentationstools: tldr ${WINE}•${RESET} cheat ${WINE}•${RESET} man"
}

# Abhängigkeitscheck
check_deps() {
    for cmd in tldr cheat man; do
        if ! command -v "$cmd" &>/dev/null; then
            echo -e "${RED}FEHLER:${RESET} '$cmd' nicht installiert!"
            echo -e "Installiere: ${WINE}os install $cmd${RESET}"
            exit 1
        fi
    done
}

# Letzter Befehl
last_command() {
    local last_cmd=$(fc -nl -1 | cut -d' ' -f2-)
    echo -e "${WINE}▸ Letzter Befehl:${RESET} ${PUNK}$last_cmd${RESET}\n"
}

# Dynamische Infoabfrage
get_command_info() {
    local cmd="$1"
    local sources=()

    # Verfügbare Quellen finden
    tldr "$cmd" &>/dev/null && sources+=("tldr")
    cheat "$cmd" &>/dev/null && sources+=("cheat")
    man "$cmd" &>/dev/null && sources+=("man")

    # Fehlerfall
    ((${#sources[@]} == 0)) && {
        echo -e "${RED}✗ Keine Docs für '$cmd'${RESET}"
        return 1
    }

    # Interaktive Auswahl
    echo -e "${WINE}▸ Dokumentation für '${PUNK}$cmd${WINE}':${RESET}"
    # PS3=$'\t'"${WINE}➤ Wähle (1-${#sources[@]}): ${RESET}"
    PS3=$'\t'"${WINE}➤ Wähle (1-${#sources[@]}):__"
    
    select src in "${sources[@]}"; do
        [[ -n $src ]] && break
        echo -e "${RED}❗ Ungültige Wahl${RESET}"
    done

    # Ausgabe mit Originalformatierung
    case "$src" in
        "tldr") tldr --color always "$cmd" ;;
        "cheat") cheat "$cmd" ;;
        "man") man -P "less -R" "$cmd" ;;
    esac
}

# Hauptprogramm
main() {
    # Optionen verarbeiten
    while getopts ":hv" opt; do
        case $opt in
            h) show_help; exit 0 ;;
            v) show_version; exit 0 ;;
            \?) echo -e "${RED}Unbekannte Option: -$OPTARG${RESET}" >&2; exit 1 ;;
        esac
    done
    shift $((OPTIND -1))
    
    check_deps

    # Befehl verarbeiten
    if (($# == 0)); then
        last_command
    else
        get_command_info "$1"
    fi
}

main "$@"
