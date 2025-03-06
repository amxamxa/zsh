#!/usr/bin/env bash

# Define color codes for terminal output to enhance readability
COL_USER="\033[38;2;0;17;204m\033[48;2;147;112;219m"
COL_ACCENT="\033[38;2;32;0;21m\033[48;2;163;64;217m"
COL_RES="\033[38;2;252;222;90m\033[48;2;0;0;139m"
COL_SUCCESS="\033[38;2;0;255;0m\033[48;2;0;100;0m"
COL_ERROR="\033[38;2;240;128;128m\033[48;2;139;0;0m"
RESET="\033[0m"

# Display help information
function show_help() {
    echo -e "\t${COL_ACCENT}was.sh - Command Documentation Explorer${RESET}"
    echo -e "\tUsage: ${COL_USER}./was.sh [OPTIONS] [COMMAND]${RESET}"
    echo -e "\n\tOptions:"
    echo -e "\t  ${COL_SUCCESS}-h, --help${RESET}    Show this help message"
    echo -e "\t  ${COL_SUCCESS}-v, --version${RESET} Show version information"
    echo -e "\n\tExamples:"
    echo -e "\t  ${COL_RES}./was.sh curl${RESET}     # Get information about curl command"
    echo -e "\t  ${COL_RES}./was.sh -v${RESET}       # Display version details"
}

# Display version information
function show_version() {
    echo -e "\t${COL_ACCENT}was.sh${RESET} | Version 0.2 | (c) 2025 Max Kempter"
    echo -e "\tDocumentation tools: ${COL_USER}tldr${RESET} ${COL_ACCENT}•${RESET} ${COL_USER}cheat${RESET} ${COL_ACCENT}•${RESET} ${COL_USER}man${RESET}"
}

# Check if required dependencies are installed
function check_deps() {
    for cmd in tldr cheat man; do
        if ! command -v "$cmd" &>/dev/null; then
            echo -e "\t${COL_ERROR}ERROR:${RESET} '${COL_RES}$cmd${COL_ERROR}' not installed!${RESET}"
            echo -e "\tInstall: ${COL_ACCENT}sudo apt install $cmd${RESET}"
            exit 1
        fi
    done
}

# Show the last executed command
function last_command() {
    local last_cmd=$(fc -nl -1 | cut -d' ' -f2-)
    echo -e "\t${COL_ACCENT}▸ Last command:${RESET} ${COL_RES}$last_cmd${RESET}\n"
}

# Fetch command documentation
function get_command_info() {
    local cmd="$1"
    local sources=("${COL_USER}cheat fuzzy${RESET}" "${COL_USER}cheat regex${RESET}" "${COL_SUCCESS}tldr${RESET}" "${COL_ACCENT}man${RESET}")

    echo -e "${COL_ACCENT}___▸ Documentation for '${COL_RES}$cmd${COL_ACCENT}':${RESET}"
    PS3="\t${COL_ACCENT}➤ Choose (1-${#sources[@]}):... ${RESET}"
}

