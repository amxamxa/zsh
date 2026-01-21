#!/usr/bin/env bash

# Filename: mopen.sh
# Description: Opens an application on a specified monitor and moves its window accordingly.
# Usage: ./mopen.sh [-h|--help] <MONITOR_NAME> <APPLICATION> [ARGS...]
# Examp
# === Color Scheme (ANSI) ===
FUCHSIA_FG="\033[38;2;255;105;180m"
FUCHSIA_BG="\033[48;2;75;0;130m"
VIOLET_FG="\033[38;2;239;217;129m"
VIOLET_BG="\033[48;2;59;14;122m"
ALERT_FG="\033[38;2;255;0;53m"
ALERT_BG="\033[48;2;34;0;82m"
INFO_FG="\033[38;2;6;88;96m"
INFO_BG="\033[48;2;144;238;144m"
RESET="\033[0m"

# === Monitor Info ===
get_monitors() {
    mapfile -t MONITORS < <(xrandr | grep " connected" | awk '{print $1}')
}

list_monitors() {
    get_monitors
    echo -e "${INFO_FG}${INFO_BG} Available monitors: ${RESET}"
    for i in "${!MONITORS[@]}"; do
        printf " %-2d  %s\n" $((i + 1)) "${MONITORS[i]}"
    done
}

# === Help ===
show_help() {
    echo -e "${FUCHSIA_FG}${FUCHSIA_BG} Usage: $0 [-h|--help] <MONITOR_NUMBER|MONITOR_NAME> <APPLICATION> [ARGS...] ${RESET}"
    echo "Launches an application and tiles it to the right half of a monitor."
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help and list available monitors."
    echo ""
    echo "Example:"
    echo "  $0 2 marker --preview file.md"
    echo ""
    list_monitors
}

# === Input Validation ===
if [[ $# -eq 0 ]]; then
    show_help
    exit 0
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

if [[ $# -lt 2 ]]; then
    echo -e "${ALERT_FG}${ALERT_BG} Error: Insufficient arguments. ${RESET}" >&2
    show_help >&2
    exit 1
fi

# === Monitor Resolution ===
get_monitors
INPUT="$1"
shift
APPLICATION_CMD=("$@")

if [[ "$INPUT" =~ ^[0-9]+$ ]]; then
    INDEX=$((INPUT - 1))
    if [[ $INDEX -lt 0 || $INDEX -ge ${#MONITORS[@]} ]]; then
        echo -e "${ALERT_FG}${ALERT_BG} Error: Invalid monitor number '$INPUT'. ${RESET}" >&2
        list_monitors >&2
        exit 1
    fi
    MONITOR_NAME="${MONITORS[INDEX]}"
else
    MONITOR_NAME="$INPUT"
fi

# === Monitor Geometry ===
GEOMETRY=$(xrandr | grep "$MONITOR_NAME connected" | grep -oE '[0-9]+x[0-9]+\+[0-9]+\+[0-9]+')
if [[ -z "$GEOMETRY" ]]; then
    echo -e "${ALERT_FG}${ALERT_BG} Error: Monitor '$MONITOR_NAME' not found. ${RESET}" >&2
    list_monitors >&2
    exit 1
fi

# === Geometry Calculation ===
WIDTH=$(echo "$GEOMETRY" | cut -d'x' -f1)
HEIGHT=$(echo "$GEOMETRY" | cut -d'x' -f2 | cut -d'+' -f1)
X_OFFSET=$(echo "$GEOMETRY" | cut -d'+' -f2)
Y_OFFSET=$(echo "$GEOMETRY" | cut -d'+' -f3)

HALF_WIDTH=$((WIDTH / 2))
RIGHT_X=$((X_OFFSET + HALF_WIDTH))

# === Launch Application ===
"${APPLICATION_CMD[@]}" &
APP_PID=$!

sleep 1.5  # wait for window to register

WINDOW_ID=$(wmctrl -lp | grep "$APP_PID" | awk '{print $1}')

if [[ -z "$WINDOW_ID" ]]; then
    echo -e "${ALERT_FG}${ALERT_BG} Warning: Could not find window by PID. Using window name fallback. ${RESET}" >&2
    WINDOW_TITLE="${APPLICATION_CMD[0]}"
    WINDOW_TITLE="$(tr '[:lower:]' '[:upper:]' <<< ${WINDOW_TITLE:0:1})${WINDOW_TITLE:1}"
    wmctrl -r "$WINDOW_TITLE" -e 0,"$RIGHT_X","$Y_OFFSET","$HALF_WIDTH","$HEIGHT"
else
    wmctrl -i -r "$WINDOW_ID" -e 0,"$RIGHT_X","$Y_OFFSET","$HALF_WIDTH","$HEIGHT"
fi

echo -e "${VIOLET_FG}${VIOLET_BG} Tiled '${APPLICATION_CMD[*]}' to right half of $MONITOR_NAME. ${RESET}"

