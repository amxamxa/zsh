#!/usr/bin/env sh
# file: cowmuh.sh
# description: Ein Skript zur Ausgabe von ASCII-Kühen mit zufälligen oder allen Cowfiles.
# dependencies: cowsay, shuf, lolcat (optional)
# usage:
#   source cowmuh.sh
#   COW_RANDOM "Dein Text"
#   COW_ALL

set -euo pipefail

# Farben und Formatierung
GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# Standardtext
DEFAULT_TEXT=${1:-"I would rather be a serf in a poor man's house and be above ground than reign among the dead.
		-- Achilles, The Odyssey, XI, 489-91"}

# Prüfe Abhängigkeiten
check_dependencies() {
  if ! command -v cowsay >/dev/null 2>&1; then
    echo "${RED}Error: 'cowsay' is not installed. Please install it first.${RESET}" >&2
    exit 1
  fi
}

# Generiere die Liste der Cowfiles
get_cow_list() {
  cowsay -l | grep -oE "[a-zA-Z0-9_-]+" | awk 'NR>=5'
}

# Zeige eine zufällige Cow
COW_RANDOM() {
  local text=$DEFAULT_TEXT
  local COW_FILES
  local SELECTED_COW

  COW_FILES=$(get_cow_list)

  if ! command -v shuf >/dev/null 2>&1; then
    echo "${RED}Warning: 'shuf' is not installed. Using 4th cow file instead.${RESET}" >&2
    SELECTED_COW=$(echo "$COW_FILES" | head -n 4)
  else
    SELECTED_COW=$(echo "$COW_FILES" | shuf -n 1)
  fi

  printf "${BOLD}${GREEN}\t %s ${RESET}" "$text" | cowsay -n -W 40 -f "$SELECTED_COW"
  return 0
}

# Zeige alle Cows
COW_ALL() {
  local text=${1:-"$DEFAULT_TEXT"}
  local COW_FILES
  local CURRENT_COW

  COW_FILES=$(get_cow_list)

  for CURRENT_COW in $COW_FILES; do
    if command -v lolcat >/dev/null 2>&1; then
      echo -e "${NIGHT}${BOLD}${UNDER}Current Cow File: $CURRENT_COW${RESET}" | lolcat -ia
    else
      echo -e ${BLINK}"Current Cow File: $CURRENT_COW"
    fi

    printf "${BOLD}${GREEN}\t %s ${RESET}" "$text" | cowsay -n -W 40 -f "$CURRENT_COW"
  done
  return 0
}

# Hauptprogramm
check_dependencies

