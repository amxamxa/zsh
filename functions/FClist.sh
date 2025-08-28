#!/usr/bin/env bash

#!/bin/bash

# Farbdefinitionen
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Funktion für farbige Ausgabe
print_colored() {
    local color=$1
    local text=$2
    echo -e "${color}${text}${NC}"
}

# Überschrift
echo
print_colored $CYAN "================================================"
print_colored $CYAN "          FONT LIST - FARBIGE DARSTELLUNG"
print_colored $CYAN "================================================"
echo

# Font-Liste abrufen und formatieren
fc-list --format "%{family}|%{style}|%{format}|%{file}\n" | while IFS='|' read -r family style format file; do
    # Überspringen leere Zeilen
    if [[ -z "$family" ]]; then
        continue
    fi
    
    # Farbige Ausgabe jeder Spalte
    print_colored $GREEN "Familie:  $family"
    print_colored $YELLOW "Stil:     $style"
    print_colored $BLUE "Format:   $format"
    print_colored $MAGENTA "Datei:    $file"
    print_colored $WHITE "----------------------------------------"
done

# Statistik am Ende
echo
print_colored $CYAN "================================================"
font_count=$(fc-list --format "%{family}\n" | wc -l)
print_colored $CYAN "Gesamtanzahl Fonts: $font_count"
print_colored $CYAN "================================================"
echo
