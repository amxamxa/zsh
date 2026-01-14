#!/usr/bin/env bash

COPYtoZ() {
    # 'echo $(fc -ln -1)' gibt den letzten Befehl aus.
    # 'tee -a $ZDOTDIR/aliases.maybe' fügt den Ausgabetext an die Datei $ZDOTDIR/aliases.maybe an.
    echo $(fc -ln -1) | tee -a $ZDOTDIR/aliases.maybe
    # Überprüft, ob der letzte Befehl erfolgreich ausgeführt wurde.
    if [ $? -eq 0 ]; then
    # Wenn Rückgabewert =0, dann Befehl erfolgreich ausgeführt und Bestätigung
      echo "${GREEN}Befehl $(fc -ln -1) wurde erfolgreich an $ZDOTDIR/aliases.maybe angehängt.${RESET}"
    else
    # Wenn der Befehl fehlgeschlagen ist, gibt diese Funktion eine Fehlermeldung aus.
    echo "${RED}Fehler beim Anhängen des Befehls $(fc -ln -1) an $ZDOTDIR/aliases.maybe.${RESET}"
    fi
}

