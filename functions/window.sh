#!/usr/bin/env bash
# Funktion: WM
# Aufgabe: Ausgabe einer formatierten Liste geöffneter Fenster mit Position und Größe
WM () {
  # Drucke eine farbige Kopfzeile (Farben aus Shell-Variablen wie $NIGHT, $RESET)
  echo -e "${NIGHT}Name         Window_ID    PID     X     Y     W     H    Desktop${RESET}"

  # führe wmctrl aus und parse die Ausgabe mit awk
  wmctrl -lpG | awk '
    {
      # Initialisiere die Variable für den Fensternamen
      name = ""

      # Schleife über alle Felder ab Feld 8 bis Ende (Fenstertitel beginnt hier)
      for (i = 8; i <= NF; i++) name = name $i " "

      # Entferne "local " am Anfang des Fensternamens (falls vorhanden)
      sub(/^local /, "", name)

      # Entferne überflüssige Leerzeichen am Ende
      gsub(/[[:space:]]+$/, "", name)

      # Trunkiere den Namen, wenn er länger als 12 Zeichen ist und füge "…" hinzu
      if (length(name) > 12) name = substr(name, 1, 11) "…"

      # Formatierte Ausgabe:
      # %-12s: linkbündig, 12 Zeichen für name
      # %-12s: Window-ID
      # %-7s : PID
      # %-4s : X-Koordinate
      # %-4s : Y-Koordinate
      # %-5s : Breite (W)
      # %-5s : Höhe (H)
      # %-8s : Desktop-Nummer
      printf "%-12s %-12s %-7s %-4s %-4s %-5s %-5s %-8s\n", name, $1, $2, $3, $4, $5, $6, $7
    }
  '
}




