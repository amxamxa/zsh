#!/usr/bin/env bash
##########################################
## ╔═╗╦╦  ╔═╗ ############################
## ╠╣ ║║  ║╣ 
## ╚  ╩╩═╝╚═╝
##  -NAME:        how.sh
##  -VERSION/tag: 0.2
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
#!/usr/bin/env bash

# Define color codes for terminal output to enhance readability
COL_USER="\033[38;2;0;17;204m\033[48;2;147;112;219m"       # fg: Dark Blue (0,17,204) | bg: Light Purple (147,112,219)
COL_ACCENT="\033[38;2;32;0;21m\033[48;2;163;64;217m"       # fg: Very Dark Purple (32,0,21) | bg: Bright Purple (163,64,217)
VIO="\033[38;2;255;0;53m\033[48;2;34;0;82m"
COL_RES="\033[38;2;252;222;90m\033[48;2;0;0;139m"          # fg: Light Yellow (252,222,90) | bg: Dark Blue (0,0,139)
COL_SUCCESS="\033[38;2;0;255;0m\033[48;2;0;100;0m"        # fg: Bright Green (0,255,0) | bg: Dark Green (0,100,0)
COL_ERROR="\033[38;2;240;128;128m\033[48;2;139;0;0m"      # fg: Light Coral (240,128,128) | bg: Dark Red (139,0,0)RESET="\033[0m"

# Display help information
function show_help() {
    echo -e "\t${COL_ACCENT}how.sh - Command Documentation Explorer${RESET}"
    echo -e "\tUsage: ${COL_RES}./how.sh [OPTIONS] [COMMAND]${RESET}"
    echo -e "\n\tOptions:"
    echo -e "\t  ${COL_ACCENT}-h, --help${RESET}    Show this help message"
    echo -e "\t  ${COL_ACCENT}-v, --version${RESET} Show version information"
    echo -e "\n\tExamples:"
    echo -e "\t  ${COL_ACCENT}./how.sh curl${RESET}     # Get information about curl command"
    echo -e "\t  ${COL_ACCENT}./how.sh -v${RESET}       # Display version details"
}

# Display version information
function show_version() {
    echo -e "\t${COL_ACCENT}how.sh${RESET} | Version 0.2 | (c) 2025 Max Kempter"
    echo -e "\tDocumentation tools: ${COL_USER}•${RESET} tldr ${COL_USER}•${RESET} cheat ${COL_USER}•${RESET}•${RESET} man"
}

# Check if required dependencies are installed
function check_deps() {
    for cmd in tldr cheat man; do
        if ! command -v "$cmd" &>/dev/null; then
            echo -e "\t${COL_ERROR}ERROR:${RESET} '$cmd' not installed!"
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
    local sources=("cheat fuzzy" "cheat regex" "tldr" "man")
    
    
    echo -e "${COL_RES} ___${COL_ACCENT}Documentation for '${COL_RES}_▸  $cmd _ ${COL_ACCENT}':${RESET}"
 echo -e "${VIO}Choose between an option: (1-${#sources[@]}):${RESET}"
select src in "${sources[@]}"; do
    [[ -n $src ]] && break
    echo -e "\t${COL_ERROR} NOPE: Invalid choice  ${RESET}"
done
    case "$src" in
        "cheat fuzzy") cheat -s "$cmd" ;;  # Uses cheat with fuzzy search
        "cheat regex") cheat -r "$cmd" ;;  # Uses cheat with regex search
        "tldr") tldr --color always "$cmd" ;;  # Retrieves TLDR page with colors
        "man") 
            if command -v bat &> /dev/null; then
                export MANPAGER="bat --paging=always --style=changes -l man -p"
            else
                export MANPAGER="less -FRX --quit-if-one-screen --no-init"
            fi
            man "$cmd"
            ;;
    esac
}

# Main script execution
function main() {
    while getopts ":hv-:" opt; do
        case $opt in
            h) show_help; exit 0 ;;  
            v) show_version; exit 0 ;;  
            -)
                case "${OPTARG}" in
                    help) show_help; exit 0 ;;  
                    version) show_version; exit 0 ;;  
                    *) echo -e "\t${COL_ERROR}Unknown option: --${OPTARG}${RESET}" >&2; exit 1 ;;  
                esac
                ;;
            \?) echo -e "\t${COL_ERROR}Unknown option: -$OPTARG${RESET}" >&2; exit 1 ;;  
        esac
    done
    shift $((OPTIND -1))  
    
    check_deps  
    
    if (($# == 0)); then
        last_command  
    else
        get_command_info "$1"  
    fi
}

main "$@"


