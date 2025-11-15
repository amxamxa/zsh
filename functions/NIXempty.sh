
#!/usr/bin/env bash
# auth:        Max Kempter
# filename:    NIXempty.sh
# version:     v0.3
# description: Advanced Nix store cleanup utility with safety checks and comprehensive logging
# changelog:   v0.3.0 - Added interactive phase confirmation, detailed error messages, and dry-run improvements
#              v0.2.0 - Added comprehensive help system and safety checks
#              v0.1.0 - Performance optimizations, conditional df checks

# Enable strict error handling for better reliability
set -euo pipefail
IFS=$'\n\t'

# --- Color Palette ---
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly BLUE='\033[0;34m'
readonly PINK='\033[0;35m'
readonly NC='\033[0m'  # No Color / Reset
readonly BOLD='\033[1m'

# --- Script Configuration ---
readonly SCRIPT_NAME="$(basename "$0")"
readonly VERSION="v0.3"
readonly LOG_FILE="/tmp/nix-cleanup-$(date +%Y%m%d-%H%M%S).log"
readonly MIN_FREE_SPACE_GB=5  # Minimum free space required in GB
DRY_RUN="${DRY_RUN:-false}"  # Can be overridden via environment
CHECK_DISK="${CHECK_DISK:-true}"  # Control df checks
DEBUG="${DEBUG:-false}"  # Debug output control

# --- Exit Codes ---
readonly EXIT_SUCCESS=0
readonly EXIT_ERROR_DEPENDENCIES=1
readonly EXIT_ERROR_DISK_SPACE=2
readonly EXIT_ERROR_NIX_DAEMON=3

# --- Logging Function ---
log_message() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "[${timestamp}] [${level}] ${message}" >> "$LOG_FILE"
    case "$level" in
        "ERROR")   echo -e "${RED}[${timestamp}] [${level}] ${message}${NC}" ;;
        "WARNING") echo -e "${YELLOW}[${timestamp}] [${level}] ${message}${NC}" ;;
        "INFO")    echo -e "${CYAN}[${timestamp}] [${level}] ${message}${NC}" ;;
        "SUCCESS") echo -e "${GREEN}[${timestamp}] [${level}] ${message}${NC}" ;;
        "DRY RUN") echo -e "${BLUE}[${timestamp}] [${level}] ${message}${NC}" ;;
        *)         echo -e "[${timestamp}] [${level}] ${message}" ;;
    esac
}

# --- Error Handler ---
cleanup_on_exit() {
    local exit_code=$?
    log_message "INFO" "Script finished with exit code: $exit_code"
    if [[ $exit_code -ne 0 ]]; then
        log_message "ERROR" "Script failed. Check $LOG_FILE for details."
        echo -e "${RED}Error: Script failed. Check $LOG_FILE for details.${NC}"
    fi
    exit $exit_code
}
trap cleanup_on_exit EXIT SIGINT SIGTERM

# --- Check Dependencies ---
check_dependencies() {
    local missing_deps=()
    local deps=("nix-env" "nix-collect-garbage" "nix-store" "find" "rm" "awk" "grep" "numfmt")
    if [[ "$CHECK_DISK" == "true" ]]; then
        deps+=("df")
    fi
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null; then
            missing_deps+=("$dep")
        fi
    done
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_message "ERROR" "Missing dependencies: ${missing_deps[*]}"
        return 1
    fi
    return 0
}

# --- Check Disk Space ---
check_disk_space() {
    if [[ "$CHECK_DISK" != "true" ]]; then
        return 0
    fi
    local free_space
    free_space=$(df -BG /nix/store | awk 'NR==2 {print $4}' | tr -d 'G')
    if [[ "$free_space" -lt "$MIN_FREE_SPACE_GB" ]]; then
        log_message "WARNING" "Low disk space: ${free_space}GB free (minimum ${MIN_FISK_SPACE_GB}GB required)."
        return 1
    fi
    return 0
}

# --- Get Store Size ---
get_store_size() {
    if ! timeout 30 command du -sb /nix/store 2>/dev/null | awk '{print $1}'; then
        log_message "WARNING" "Failed to get store size with 'du'. Falling back to 'df'..."
        df -B1 /nix/store | awk 'NR==2 {print $3}'
    fi
}

# --- Check for Running Nix Daemon ---
check_nix_daemon() {
    # Check if the daemon process is running (not just the socket)
    if systemctl is-active --quiet nix-daemon.service 2>/dev/null; then
        log_message "ERROR" "Nix daemon is running. Please stop it before cleanup."
        return 1
    fi
    # Fallback: Check for any remaining nix-daemon processes
    if pgrep -x nix-daemon >/dev/null; then
        log_message "ERROR" "Nix daemon process detected. Please stop it before cleanup."
        return 1
    fi
    return 0
}

# --- Print Header ---
print_header() {
    cat <<EOF

${BOLD}${BLUE}

 _, _ _ _  ,
 |\ | | '\/ 
 | \| |  /\ 
 ~  ~ ~ ~  ~
            
 __, _, _ __, ___ , _
 |_  |\/| |_)  |  \ |
 |   |  | |    |   \|
 ~~~ ~  ~ ~    ~    )
                   ~'
                  +
                  
 ${NC}

${CYAN}NIXempty.sh ${VERSION}${NC}
Log file: ${LOG_FILE}
Options: DRY_RUN=$DRY_RUN, CHECK_DISK=$CHECK_DISK, DEBUG=$DEBUG
---
EOF
}

# --- Help Function ---
show_help() {
    cat <<EOF
${BOLD}${SCRIPT_NAME}${NC} - Advanced Nix Store Cleanup Utility

${BOLD}Description:${NC}
  This script cleans up the Nix store by removing old generations, garbage collecting,
  and optimizing the store. It includes safety checks and comprehensive logging.

${BOLD}Usage:${NC}
  $SCRIPT_NAME [OPTIONS]

${BOLD}Options:${NC}
  --dry-run          Perform a dry run (no changes made)
  --no-check-disk    Skip disk space check
  --debug            Enable debug output
  --help             Show this help message
  --version          Show version information

${BOLD}Examples:${NC}
  $SCRIPT_NAME --dry-run
  $SCRIPT_NAME --no-check-disk
  $SCRIPT_NAME --debug

${BOLD}Notes:${NC}
  - Ensure you have write permissions for the Nix store.
  - The script logs all actions to $LOG_FILE.
EOF
}

# --- Main Cleanup Function ---
NIXempty() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run)      DRY_RUN=true ;;
            --no-check-disk) CHECK_DISK=false ;;
            --debug)        DEBUG=true ;;
            --help)         show_help; exit 0 ;;
            --version)      echo "$VERSION"; exit 0 ;;
            *)              log_message "ERROR" "Unknown argument: $1"; show_help; exit 1 ;;
        esac
        shift
    done

    # Initialization
    print_header
    log_message "INFO" "Starting Nix store cleanup..."

    # Pre-checks
    if ! check_dependencies; then
        exit $EXIT_ERROR_DEPENDENCIES
    fi
    if ! check_disk_space; then
        log_message "WARNING" "Continuing despite low disk space..."
    fi
    if ! check_nix_daemon; then
        exit $EXIT_ERROR_NIX_DAEMON
    fi

    # Get initial store size
    local initial_size
    initial_size=$(get_store_size)
    log_message "INFO" "Initial store size: $(numfmt --to=iec --suffix=B "$initial_size")"

    # Safety confirmation
    echo -e "${YELLOW}WARNING: This script will permanently delete data from the Nix store.${NC}"
    read -rp "Do you want to continue? (y/N) " answer
    if [[ "$answer" != "y" ]]; then
        log_message "INFO" "User aborted."
        exit 0
    fi

    # --- Phase 1: Clean GC Roots ---
    echo -e "\n${BOLD}${CYAN}Phase 1: Cleaning GC Roots...${NC}"
    if [[ "$DRY_RUN" == "true" ]]; then
        log_message "DRY RUN" "Would clean GC roots in /nix/var/nix/gcroots/auto."
    else
        log_message "INFO" "Removing broken symlinks in /nix/var/nix/gcroots/auto..."
        command find /nix/var/nix/gcroots/auto -type l -xtype l -print -delete 2>&1 | tee -a "$LOG_FILE"
        log_message "INFO" "Removing old GC roots in /nix/var/nix/gcroots/auto..."
        command find /nix/var/nix/gcroots/auto -type l -delete 2>&1 | tee -a "$LOG_FILE"
        log_message "SUCCESS" "GC roots cleaned."
    fi

    # --- Phase 2: Delete Old Generations ---
    echo -e "\n${BOLD}${CYAN}Phase 2: Deleting old generations...${NC}"
    if [[ "$DRY_RUN" == "true" ]]; then
        log_message "DRY RUN" "Would delete old user and system generations."
    else
        log_message "INFO" "Deleting old user generations..."
        command nix-env --delete-generations old 2>&1 | tee -a "$LOG_FILE"
        if [[ -f /etc/nixos/configuration.nix ]]; then
            log_message "INFO" "NixOS detected. Deleting old system generations..."
            command nix-env --delete-generations old --profile /nix/var/nix/profiles/system 2>&1 | tee -a "$LOG_FILE"
        fi
        log_message "SUCCESS" "Old generations deleted."
    fi

    # --- Phase 3: Garbage Collection ---
    echo -e "\n${BOLD}${CYAN}Phase 3: Running garbage collection...${NC}"
    if [[ "$DRY_RUN" == "true" ]]; then
        log_message "DRY RUN" "Would run garbage collection."
    else
        log_message "INFO" "Running garbage collection..."
        timeout 3600 nix-collect-garbage -d 2>&1 | tee -a "$LOG_FILE"
        log_message "SUCCESS" "Garbage collection completed."
    fi

    # --- Phase 4: Store Optimization ---
    echo -e "\n${BOLD}${CYAN}Phase 4: Optimizing store...${NC}"
    if [[ "$DRY_RUN" == "true" ]]; then
        log_message "DRY RUN" "Would optimize store (deduplication)."
    else
        log_message "INFO" "Optimizing store..."
        command nix-store --optimise 2>&1 | tee -a "$LOG_FILE"
        log_message "SUCCESS" "Store optimization completed."
    fi

    # --- Results ---
    local final_size
    final_size=$(get_store_size)
    local saved_space=$((initial_size - final_size))
    echo -e "\n${BOLD}${GREEN}--- Results ---${NC}"
    echo "Initial store size: $(numfmt --to=iec --suffix=B "$initial_size")"
    echo "Final store size:   $(numfmt --to=iec --suffix=B "$final_size")"
    echo "Space saved:        ${GREEN}$(numfmt --to=iec --suffix=B "$saved_space")${NC}"
    log_message "SUCCESS" "Cleanup completed. Space saved: $(numfmt --to=iec --suffix=B "$saved_space")"

    # --- Notification ---
    if command -v notify-send >/dev/null; then
        notify-send "Nix Store Cleanup" "Cleanup completed. Space saved: $(numfmt --to=iec --suffix=B "$saved_space")"
    fi
}

# --- Main Execution ---
NIXempty "$@"



