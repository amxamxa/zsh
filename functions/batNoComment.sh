#!/usr/bin/env sh
# filename:   batNoComment.sh

# Das Skript entfernt nun zuverlässig Kommentare aus 
# Skripten, während Strings erhalten bleiben.

alias bap-NoComment=batNoComment.sh

# Überprüfen, ob ein Dateiname übergeben
wurde
    if [[ -z "$1" ]]; then
        echo "Bitte einen Dateinamen angeben.
"
        return 1
    fi

    # Überprüfen, ob die Datei existiert
    if [[ ! -f "$1" ]]; then
        echo "Die Datei '$1' existiert nicht.
"
        return 1
    fi

    # Überprüfen, ob `bat` installiert ist
    if ! command -v bat > /dev/null 2>&1; the
n
        echo "Das Tool 'bat' ist nicht instal
liert. Bitte installieren und erneut versuche
n."
        return 1
    fi

    # Datei mit bat ausgeben, Kommentare entf
ernen
   command bat --color=always --language=zsh
-p "$1" | awk '
        BEGIN { in_string = 0 }
        {
            # Überprüfen, ob wir uns in einem String befinden
            for (i = 1; i <= length($0); i++) {
                char = substr($0, i, 1)

                # Umschalten bei Stringbeginn oder -ende
                if (char == "\"" && (i == 1 || substr($0, i - 1, 1) != "\\")) {
                    in_string = !in_string
                }

                # Nur Kommentare entfernen, die nicht in Strings stehen
                if (!in_string && char == "#") {
                    $0 = substr($0, 1, i - 1) # Kommentar abschneiden
                    break
                }
            }
        }
        NF { print } # Nur nicht-leere Zeilen ausgeben
    '
}
