#!/usr/bin/env bash
# auth:______max__kempter_______ 
# filename:______NIXbuild.sh 

# Dieses Skript baut NixOS neu, bietet Optionen für Boot, Switch und VM-Build, 
# und erlaubt es dem Nutzer, das Profil und Upgrade-Optionen festzulegen.
# Anleitung zur Nutzung:
#   1. Skript mit `sudo ./NIXbuild.sh` ausführen, falls keine sudo-Rechte vorhanden.
#   2. Folgen Sie den Anweisungen im Skript, um BUILD, UPGRADE und NAME festzulegen.
#   3. Das Skript führt am Ende den Befehl `nixos-rebuild` mit den gewünschten Parametern aus.

# Farben definieren
SKY="\033[38;2;165;60;230m\033[48;2;60;1;85m"  # Blau für Benutzerinteraktion (fg: #3e2481, bg: #87CEEB)
RED="\033[38;2;240;128;128m\033[48;2;139;0;0m"    # Rot für Fehler (fg: #F08080, bg: #8B0000)
RASPBERRY="\033[38;2;32;0;21m\033[48;2;221;160;221m" # Lila für Akzent (fg: #200015, bg: #DDA0DD)
RESET="\033[0m"
# Handle sudo permissions interactively
if [ "$EUID" -ne 0 ]; then
    echo -e "\t${RASPBERRY}⚠️ This script requires administrator privileges. ⚠️ ${RESET}"
    echo -e "\t${GREEN}Requesting sudo permissions interactively...${RESET}"
    exec sudo -k "$0" "$@"
    exit 1
fi

# Funktion für Countdown mit Abbruchmöglichkeit
countdown() {
    secs=10
    while [ $secs -gt 0 ]; do
        echo -ne "\tDrücke Enter zum Bestätigen oder Ctrl+C zum Abbrechen... ($secs)\r"
        read -t 1 && break
        secs=$((secs-1))
    done
    echo -ne "\n"
}

# 1. Editor öffnen
read -p -r "$(echo -e "\t${SKY}Soll der Editor für /etc/nixos/*.nix geöffnet werden? \n\t\t${RASPBERRY}(Enter für Ja, nN für Nein): ${RESET}")" editor_choice
if [[ "$editor_choice" != "n" && "$editor_choice" != "N" ]]; then
    gnome-text-editor --ignore-session --standalone --new-window /etc/nixos/*.nix 2>/dev/null￼￼ || micro  /etc/nixos/*.nix 2>/dev/null
fi
echo
# 2. $BUILD setzen
read -p -r "$(echo -e "\t${SKY}Wie soll \$BUILD definiert werden?\n\t\t${RASPBERRY}(b für boot, s für switch, v für build-vm): ${RESET}")" build_choice
case $build_choice in
    b) BUILD="boot" ;;
    s) BUILD="switch" ;;
    v) BUILD="build-vm" ;;
    *) echo -e "\t${RED}Ungültige Auswahl. Skript wird beendet.${RESET}"; exit 1 ;;
esac
echo
# 3. $UPGRADE Option
read -p -r "$(echo -e "\t${SKY}Soll die Option --upgrade gesetzt werden? \n\t\t${RASPBERRY}(Enter für 'Nein', up für '--upgrade'): ${RESET}")" upgrade_choice
if [[ "$upgrade_choice" == "up" ]]; then
    UPGRADE="--upgrade"
else
    UPGRADE=""
fi
echo
# 4. $NAME setzen
# Zeile für Ausgabe von 'default_name'
echo -e "\t${RASPBERRY}Default Name ist: \t ${RED}$default_name${RESET}"
# Eingabeaufforderung für den Benutzernamen
read -p -r "$(echo -e "\t${SKY}Wie soll \$NAME gesetzt werden? \n\t\t${RASPBERRY}(Enter für $default_name): ${RESET}")" profile_name
# Setze den Namen auf den Wert des Benutzers oder den Standardwert
NAME=${profile_name:-$default_name}
# Zeige den gesetzten Namen an
echo -e "${SKY}Der gesetzte Name und die Wahloption in GRUB: ${PINK} $NAME ${RESET}"

#default_name="24.11_4xam"
#echo -e "\t${RASPBERRY}echo "Default Name ist: \t ${RED} $default_name"
#read -p -r "$(echo -e "\t${SKY}Wie soll \$NAME gesetzt werden? \n\t\t${RASPBERRY}(Enter für $default_name): ${RESET}")" profile_name"
#NAME=${profile_name:-$default_name}
#echo

# 5. Hinweis über -I nixos-config
echo -e "\t${SKY}Hinweis: -I nixos-config=/etc/nixos/configuration.nix wird verwendet.${RESET}"
echo

# 6. Bestätigung vor Ausführung
echo -e "\n\t${SKY}Der folgende Befehl wird ausgeführt:"
echo -e "\t\t${RASPBERRY}sudo nixos-rebuild "$BUILD""
echo -e "\t\t--show-trace $UPGRADE --profile-name "$NAME""
echo -e "\t\t -I nixos-config=/etc/nixos/configuration.nix${RESET}\n"
countdown

# 7. Ausführung des Befehls
echo -e "\t${SKY}Führe Befehl aus...${RESET}"
sudo nixos-rebuild "$BUILD" --show-trace $UPGRADE --profile-name "$NAME" -I nixos-config=/etc/nixos/configuration.nix
