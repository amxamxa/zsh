#!/usr/bin/env bash
# ========================================
# File: cowmuh.sh
# Description:
#   A CLI tool that prints cowsay ASCII cows with optional
#   random selection, full listing, custom text, and color
#   control. The script is designed to be safely sourced
#   without altering the user's interactive shell environment.
#
# Safe Sourcing:
#   - When sourced, the script does NOT execute main()
#   - When sourced, it does NOT enable 'set -euo pipefail'
#   - When sourced, it does NOT overwrite shell options
#   - All variables are namespaced to avoid collisions
#
# Usage Examples:
#   ./cowmuh.sh --random
#   ./cowmuh.sh --all --text "Hello World"
#   ./cowmuh.sh --random --no-color
#
# Features:
#   --random        Show a random cow
#   --all           Show all available cows
#   --text "TEXT"   Set the text for the cow
#   --no-color      Disable ANSI colors
#   --help          Show usage
#
# =========================================
# Only enable strict mode when script is executed normally.
# When sourced, strict mode would break the user's shell.
# ----------------------------
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    set -euo pipefail
fi

# ------------------------------------------
# Namespace prefix to avoid polluting the user's shell
_cowmuh_PREFIX="cowmuh"
# ------------------------------------------
# Color and formatting variables
# These are safe to override because they are namespaced.
cowmuh_ENABLE_COLORS=1
COLOR_G="\033[32m"
COLOR_R="\033[31m"
cowmuh_COLOR_GREEN="${CYAN:-$COLOR_G}"
cowmuh_COLOR_RED="${PINK2:-COLOR_R}"
cowmuh_COLOR_RESET="\033[0m"
cowmuh_STYLE_BOLD="\033[1m"
cowmuh_STYLE_UNDERLINE="\033[4m"
cowmuh_STYLE_BLINK="\033[5m"

cowmuh_disable_colors() {
    cowmuh_ENABLE_COLORS=0
    cowmuh_COLOR_GREEN=""
    cowmuh_COLOR_RED=""
    cowmuh_COLOR_RESET=""
    cowmuh_STYLE_BOLD=""
    cowmuh_STYLE_UNDERLINE=""
    cowmuh_STYLE_BLINK=""
}

# ----------------------------------
# Print an error message (stderr)
cowmuh_error() {
    # Using namespaced variables ensures no collision
    echo -e "${cowmuh_COLOR_RED}Error:${cowmuh_COLOR_RESET} $*" >&2
    return 1
}
cowmuh_warn() {
    echo -e "${cowmuh_COLOR_RED}Warning:${cowmuh_COLOR_RESET} $*" >&2
}

# ------------------------------------
# Check for required dependencies
cowmuh_check_dependencies() {
    if ! command -v cowsay >/dev/null 2>&1; then
        cowmuh_error "'cowsay' is not installed."
        return 1
    fi
    return 0
}

# ----------------------------------------
# Retrieve list of available cowfiles
cowmuh_get_cow_list() {
  cowsay -l | grep -oE "[a-zA-Z0-9_-]+" | awk 'NR>=5'
}

# -------------------------------------------
# Show a random cow with optional text
# -----------------------------------------
cowmuh_show_random_cow() {
    local text="$1"
    local cow_list selected_cow

    cow_list=$(cowmuh_get_cow_list)

    if [[ -z "$cow_list" ]]; then
        cowmuh_error "No cowfiles found."
        return 1
    fi

    if command -v shuf >/dev/null 2>&1; then
        selected_cow=$(printf "%s\n" $cow_list | shuf -n 1)
    else
        cowmuh_warn "'shuf' missing – using first cowfile."
        selected_cow=$(printf "%s\n" $cow_list | head -n 1)
    fi

#    printf "%s%s%s\n" \
 echo -e ""$cowmuh_STYLE_BOLD" \
        "$cowmuh_COLOR_GREEN" \
        "$text" "\
        | cowsay -n -W 40 -f "$selected_cow"
}

# ----------------------------------------
# Show all cows with optional text
cowmuh_show_all_cows() {
    local text="$1"
    local cow_list cow

    cow_list=$(cowmuh_get_cow_list)

    if [[ -z "$cow_list" ]]; then
        cowmuh_error "No cowfiles found."
        return 1
    fi

    for cow in $cow_list; do
        if command -v lolcat >/dev/null 2>&1; then
            echo "Current Cow File: $cow" | lolcat -ia
        else
            echo -e "${cowmuh_STYLE_BLINK}Current Cow File: $cow${cowmuh_COLOR_RESET}"
        fi

        printf "%s%s%s\n" \
            "$cowmuh_STYLE_BOLD" \
            "$cowmuh_COLOR_GREEN" \
            "$text" \
            | cowsay -n -W 40 -f "$cow"
    done
}

# ----------------------------------------
# Main CLI argument parser and dispatcher
cowmuh_main() {
    local mode=""
    local text="... fuck you two..."

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --random)
                mode="random"
                ;;
            --all)
                mode="all"
                ;;
            --text)
                shift
                text="${1:-}"
                if [[ -z "$text" ]]; then
                    cowmuh_error "--text requires a value."
                    return 1
                fi
                ;;
            --no-color)
                cowmuh_disable_colors
                ;;
            --help|-h)
                echo "Usage: $0 [--random|--all] [--text \"TEXT\"] [--no-color]"
                return 0
                ;;
            *)
                cowmuh_error "Unknown option: $1"
                return 1
                ;;
        esac
        shift
    done

    cowmuh_check_dependencies || return 1

    case "$mode" in
        random)
            cowmuh_show_random_cow "$text"
            ;;
        all)
            cowmuh_show_all_cows "$text"
            ;;
        "")
            cowmuh_error "No mode selected. Use --random or --all."
            return 1
            ;;
    esac
}

# ------------------------------------
# Execute main() only when run directly, not when sourced
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    cowmuh_main "$@"
fi
