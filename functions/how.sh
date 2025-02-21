#!/usr/bin/env bash
##########################################
## ╔═╗╦╦  ╔═╗ ############################
## ╠╣ ║║  ║╣ 
## ╚  ╩╩═╝╚═╝
##  -NAME:        how.sh
##  -VERSION/tag: 0.1
##  -AUTHOR:      max kempter
##  -Github:      github.com/amxamxa/was.sh
## - DATE:        2025-Feb-20                
## ---------------------------------------
## To do/ Known Bugs /or depends:
##   • Requires tldr, cheat, and man to be installed.
## ---------------------------------------
## Command Documentation Explorer
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## This script collects information about commands using tldr, cheat, and man
## with advanced formatting options and help functions. It provides an interactive
## way to explore command documentation and supports dynamic source selection.
##
## Main functions/workflow:
##   • Checks for required dependencies (tldr, cheat, man).
##   • Displays help and version information.
##   • Retrieves and displays documentation for a specified command.
##   • Supports interactive selection of documentation sources (tldr, cheat, man).
##   • Displays the last executed command if no arguments are provided.
## ---------------------------------------
## COMMENTS: Advanced formatting and color support included.
##########################################

# Define color codes for terminal output
GREEN="\033[38;2;0;255;0m\033[48;2;0;25;2m"
RED="\033[38;2;240;138;100m\033[48;2;147;18;61m"
YELLOW="\033[38;2;232;197;54m\033[48;2;128;87;0m"
BLINK="\033[5m"  	# blink	 txt 
RESET="\033[0m"

# Help function
show_help() {
    echo -e "${WINE}was.sh - Command Documentation Explorer${RESET}"
    echo -e "Usage: ${WINE}./was.sh [OPTIONS] [COMMAND]${RESET}"
    echo -e "\nOptions:"
    echo -e "  ${WINE}-h${RESET}    Show this help"
    echo -e "  ${WINE}-v${RESET}    Show version information"
    echo -e "\nExamples:"
    echo -e "  ${WINE}./was.sh curl${RESET}     # Info about curl"
    echo -e "  ${WINE}./was.sh -v${RESET}      # Show version"
}

# Version info
show_version() {
    echo -e "${WINE}was.sh ${RESET}| Version 0.1 | (c) 2025 max kempter"
    echo -e "Documentation tools: tldr ${WINE}•${RESET} cheat ${WINE}•${RESET} man"
}

# Dependency check
check_deps() {
    for cmd in tldr cheat man; do
        if ! command -v "$cmd" &>/dev/null; then
            echo -e "${RED}ERROR:${RESET} '$cmd' not installed!"
            echo -e "Install: ${WINE}os install $cmd${RESET}"
            exit 1
        fi
    done
}

# Last command
last_command() {
    local last_cmd=$(fc -nl -1 | cut -d' ' -f2-)
    echo -e "${WINE}▸ Last command:${RESET} ${PUNK}$last_cmd${RESET}\n"
}

# Dynamic info query
get_command_info() {
    local cmd="$1"
    local sources=()

  # Find available sources
    tldr "$cmd" &>/dev/null && sources+=("tldr")
    cheat "$cmd" &>/dev/null && sources+=("cheat")
    man "$cmd" &>/dev/null && sources+=("man")

  # Error case
    ((${#sources[@]} == 0)) && {
        echo -e "${RED}✗ No docs for '$cmd'${RESET}"
        return 1
    }
  # Interactive selection
    echo -e "${WINE}▸ Documentation for '${PUNK}$cmd${WINE}':${RESET}"
    PS3=$'\t'"${WINE}➤ Choose (1-${#sources[@]}):__"
   
    select src in "${sources[@]}"; do
        [[ -n $src ]] && break
        echo -e "${RED}❗ Invalid choice${RESET}"
    done

  # Output with original formatting
    case "$src" in
        "tldr") tldr --color always "$cmd" ;;
        "cheat") cheat -p "$cmd" ;;
        "man") man -P "less -R" "$cmd" ;;
    esac
}

# Main program
main() {
    # Process options
    while getopts ":hv" opt; do
        case $opt in
            h) show_help; exit 0 ;;
            v) show_version; exit 0 ;;
            \?) echo -e "${RED}Unknown option: -$OPTARG${RESET}" >&2; exit 1 ;;
        esac
    done
    shift $((OPTIND -1))
    
    check_deps

    # Process command
    if (($# == 0)); then
        last_command
    else
        get_command_info "$1"
    fi
}

main "$@"


