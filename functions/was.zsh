#!/usr/bin/env zsh

# Farbcodes definieren für die Ausgabe im Terminal
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
YELLOW="\033[38;2;232;197;54m\033[48;2;128;87;0m"
	BLINK	= "\033[5m";  	# blink	 txt 
		
RESET="\033[0m"

# Prüfen, ob die benötigten Info-Apps installiert sind
for cmd in tldr cheat man navi; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${YELLOW} Fehler: $cmd ist nicht installiert.${RESET}\n" #${YELLOW}
        exit 1
    fi
done

# Funktion zum Anzeigen des letzten ausgeführten Befehls
last_command() {
    last_cmd=$(fc -n -l -1 -1)
    echo -e "${GREEN}Letzter Befehl: $last_cmd${RESET}"
}

# Funktion zur Informationsbeschaffung über einen Befehl
get_command_info() {
    local cmd=$1
    local info=""
    local tldr_output=""
    local cheat_output=""

    tldr_output=$(tldr $cmd 2>&1)
    if [ $? -eq 0 ]; then
        info="$tldr_output"
        echo -e "${GREEN}tldr Ausgabe: $tldr_output${RESET}"
    else
        echo -e "${RED}Fehler beim Abrufen von tldr Informationen für $cmd${RESET}"
    fi

    cheat_output=$(cheat $cmd 2>&1)
    if [ $? -eq 0 ]; then
        if [ "$cheat_output" != "$tldr_output" ]; then
            info="$cheat_output"
            echo -e "${GREEN}cheat Ausgabe: $cheat_output${RESET}"
        fi
    else
        echo -e "${RED}Fehler beim Abrufen von cheat Informationen für $cmd${RESET}"
    fi

    if [ -z "$info" ]; then
        man_output=$(man $cmd 2>&1)
        if [ $? -eq 0 ]; then
            info="$man_output"
            echo -e "${GREEN}man Ausgabe: $man_output${RESET}"
        else
            echo -e "${RED}Fehler beim Abrufen von man Informationen für $cmd${RESET}"
        fi
    fi

    if [ -z "$info" ]; then
        help_output=$($cmd --help 2>&1)
        if [ $? -eq 0 ]; then
            info="$help_output"
            echo -e "${GREEN}--help Ausgabe: $help_output${RESET}"
        else
            usage_output=$($cmd --usage 2>&1)
            if [ $? -eq 0 ]; then
                info="$usage_output"
                echo -e "${GREEN}--usage Ausgabe: $usage_output${RESET}"
            else
                echo -e "${RED}Fehler beim Abrufen von --help oder --usage Informationen für $cmd${RESET}"
            fi
        fi
    fi

    if [ -z "$info" ]; then
        navi_output=$(navi $cmd 2>&1)
        if [ $? -eq 0 ]; then
            info="$navi_output"
            echo -e "${GREEN}navi Ausgabe: $navi_output${RESET}"
        else
            echo -e "${RED}Fehler beim Abrufen von navi Informationen für $cmd${RESET}"
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

