#!/usr/bin/env bash
# auth:        _______max_kempter_________
# filename:    _______NIXempty.sh_____
# version:     2.1.0
# description: Advanced Nix store cleanup utility with safety checks
# changelog:   v2.1.0 - Performance optimizations, conditional df checks
# ============================================================================
# GLOBAL CONFIGURATION AND COLOR DEFINITIONS
# ============================================================================

# Enable strict error handling for better reliability
set -euo pipefail
IFS=$'\n\t'

# Color palette using ANSI escape codes
readonly SKY="\033[38;2;62;36;129m\033[48;2;135;206;235m"
readonly RED="\033[38;2;240;128;128m\033[48;2;139;0;0m"
readonly RASPBERRY="\033[38;2;32;0;21m\033[48;2;221;160;221m"
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly BLUE='\033[0;34m'
readonly PINK='\033[0;35m'
readonly NC='\033[0m'  # No Color / Reset
readonly BOLD='\033[1m'

# Script configuration
readonly SCRIPT_NAME="$(basename "$0")"
readonly VERSION="2.1.0"
readonly LOG_FILE="/tmp/nix-cleanup-$(date +%Y%m%d-%H%M%S).log"
readonly MIN_FREE_SPACE_GB=5  # Minimum free space required in GB
readonly DRY_RUN="${DRY_RUN:-false}"  # Can be overridden via environment
readonly CHECK_DISK="${CHECK_DISK:-true}"  # NEW: Control df checks
readonly DEBUG="${DEBUG:-false}"  # Debug output control

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

# Logging function with timestamp and level support
# Usage: log_message "INFO" "Message text"
log_message() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Write to log file
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    
    # Display to console with appropriate color
    case "$level" in
        ERROR)   echo -e "${RED}❌ $message${NC}" >&2 ;;
        WARNING) echo -e "${YELLOW}⚠️  $message${NC}" ;;
        INFO)    echo -e "${CYAN}ℹ️  $message${NC}" ;;
        SUCCESS) echo -e "${GREEN}✅ $message${NC}" ;;
        DEBUG)   [[ "$DEBUG" == "true" ]] && echo -e "${BLUE}🔍 $message${NC}" ;;
    esac
}

# Error handler with cleanup on exit
cleanup_on_exit() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        log_message "ERROR" "Script terminated with exit code: $exit_code"
        echo -e "\n${RED}❌ Cleanup interrupted! Check log: $LOG_FILE${NC}"
    fi
}

# Register cleanup function for various signals
trap cleanup_on_exit EXIT INT TERM

# Check if running with proper privileges
check_privileges() {
    if [[ $EUID -eq 0 ]]; then
        log_message "WARNING" "Running as root directly. Consider using sudo instead."
    elif ! sudo -n true 2>/dev/null; then
        log_message "ERROR" "This script requires sudo privileges"
        echo -e "${YELLOW}Please run: sudo -v${NC}"
        return 1
    fi
}

# Verify all required commands are available
check_dependencies() {
    local missing=()
    local required_cmds=(
        "du"                  # Disk usage calculation
        "numfmt"              # Human-readable size formatting
        "sudo"                # Privilege escalation
        "nix-collect-garbage" # Nix garbage collection
        "nix-store"           # Store optimization
        "find"                # File system operations
        "awk"                 # Text processing
        "xargs"               # Parallel operations
    )
    
    # df is optional when CHECK_DISK=false
    if [[ "$CHECK_DISK" == "true" ]]; then
        required_cmds+=("df")
    fi
    
    for cmd in "${required_cmds[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done
    
    if (( ${#missing[@]} > 0 )); then
        log_message "ERROR" "Missing required commands: ${missing[*]}"
        echo -e "${YELLOW}Install missing tools via nix-env or configuration.nix${NC}"
        return 1
    fi
    
    log_message "INFO" "All dependencies satisfied"
    return 0
}

# Check available disk space before cleanup (OPTIMIZED)
# Only runs when CHECK_DISK=true
check_disk_space() {
    # Skip if disabled
    if [[ "$CHECK_DISK" == "false" ]]; then
        log_message "INFO" "Disk space check disabled (CHECK_DISK=false)"
        return 0
    fi
    
    local available_gb
    if ! available_gb=$(df /nix/store 2>/dev/null | awk 'NR==2 {print int($4/1048576)}'); then
        log_message "WARNING" "Could not determine disk space"
        return 0  # Continue anyway
    fi
    
    if [[ -z "$available_gb" ]]; then
        log_message "WARNING" "Disk space check returned empty result"
        return 0
    fi
    
    if [[ $available_gb -lt $MIN_FREE_SPACE_GB ]]; then
        log_message "WARNING" "Low disk space: ${available_gb}GB available"
        echo -e "${YELLOW}Consider freeing space manually first${NC}"
        return 1
    fi
    
    log_message "INFO" "Available disk space: ${available_gb}GB"
    return 0
}

# Get store size with error handling and fallback (OPTIMIZED)
# Returns size in bytes or uses df-based estimation
get_store_size() {
    local size_bytes
    
    log_message "DEBUG" "Calculating store size..."
    
    # Primary method: du with timeout and max-depth optimization
    if size_bytes=$(timeout 30 du -sb --max-depth=0 /nix/store 2>/dev/null | awk '{print $1}'); then
        if [[ "$size_bytes" =~ ^[0-9]+$ ]] && [[ $size_bytes -gt 0 ]]; then
            log_message "DEBUG" "Store size calculated via du: $size_bytes bytes"
            echo "$size_bytes"
            return 0
        fi
    fi
    
    # Fallback: df-based estimation (faster but less accurate)
    log_message "WARNING" "du failed, using df-based estimation"
    
    if command -v df >/dev/null 2>&1; then
        local used_kb
        if used_kb=$(df /nix/store 2>/dev/null | awk 'NR==2 {print $3}'); then
            if [[ "$used_kb" =~ ^[0-9]+$ ]] && [[ $used_kb -gt 0 ]]; then
                size_bytes=$((used_kb * 1024))
                log_message "WARNING" "Using df estimation: $size_bytes bytes"
                echo "$size_bytes"
                return 0
            fi
        fi
    fi
    
    # Last resort: return error
    log_message "ERROR" "Failed to calculate store size"
    echo "-1"
    return 1
}

# Display formatted header with version info
print_header() {
    echo -e "${PINK}\t____________________________________________________"
    echo -e "${CYAN}\t______________________________________________________"
    echo -e "\t/_____/_____/_____/_____/_____/_____/_____/_____/_____/"
    echo -e "\t         _____/ /__  ____ _____  ___  _____     "
    echo -e "\t        / ___/ / _ \/ __ // __ \/ _ \/ ___/     "
    echo -e "\t      / /__/ /  __/ /_/ / / / /  __/ /    "
    echo -e "\t      \___/_/\___/\__,_/_/ /_/\___/_/    "
    echo -e "\t______________________________________________________"
    echo -e "\t_/_____/_____/_____/_____/_____/_____/_____/_____/_____/"
    echo -e "${PINK}\n\t=== Nix Store Cleaner v${VERSION} ===${NC}"
    echo -e "${CYAN}\t____________________________________________________\n${NC}"
    echo -e "${BLUE}Log file: $LOG_FILE${NC}"
    
    # Show active options
    if [[ "$DRY_RUN" == "true" ]] || [[ "$CHECK_DISK" == "false" ]] || [[ "$DEBUG" == "true" ]]; then
        echo -e "${YELLOW}Active options:${NC}"
        [[ "$DRY_RUN" == "true" ]] && echo -e "  • DRY_RUN enabled"
        [[ "$CHECK_DISK" == "false" ]] && echo -e "  • Disk space check disabled"
        [[ "$DEBUG" == "true" ]] && echo -e "  • Debug mode enabled"
    fi
    echo ""
}

# ============================================================================
# MAIN CLEANUP FUNCTION
# ============================================================================

NIXempty() {
    # Initialize logging
    log_message "INFO" "Starting Nix Store Cleaner v${VERSION}"
    log_message "INFO" "Configuration: DRY_RUN=$DRY_RUN, CHECK_DISK=$CHECK_DISK, DEBUG=$DEBUG"
    
    # Display header
    print_header
    
    # Perform prerequisite checks
    if ! check_privileges; then
        return 1
    fi
    
    if ! check_dependencies; then
        return 1
    fi
    
    if ! check_disk_space; then
        echo -e "${YELLOW}Continue anyway? Low disk space detected.${NC}"
        if [[ -n "${ZSH_VERSION:-}" ]]; then
            read -q "REPLY?❓ Proceed despite low disk space? (y/N) "
            echo
        else
            read -r -p "❓ Proceed despite low disk space? (y/N) " REPLY
        fi
        
        if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
            log_message "INFO" "User cancelled due to low disk space"
            return 0
        fi
    fi
    
    # Check for active Nix builds (ENHANCED)
    if pgrep -f "nix-build|nix-shell|nixos-rebuild|nix-env|nix-instantiate" >/dev/null 2>&1; then
        log_message "WARNING" "Active Nix operations detected"
        echo -e "${YELLOW}⚠️  Active Nix operations detected:${NC}"
        pgrep -fa "nix-" | grep -v "$SCRIPT_NAME" | sed 's/^/  • /' | head -n 5 || true
        echo -e "${YELLOW}Cleanup during builds may cause issues.${NC}"
        
        if [[ -n "${ZSH_VERSION:-}" ]]; then
            read -q "REPLY?❓ Continue anyway? (y/N) "
            echo
        else
            read -r -p "❓ Continue anyway? (y/N) " REPLY
        fi
        
        if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
            log_message "INFO" "User cancelled due to active operations"
            return 0
        fi
    fi
    
    # Get initial store size
    echo -e "${YELLOW}🔍 Analyzing Nix store...${NC}"
    local before_bytes
    before_bytes=$(get_store_size)
    
    if [[ $before_bytes -eq -1 ]]; then
        echo -e "${RED}❌ Failed to determine store size${NC}"
        echo -e "${YELLOW}Continue without size tracking?${NC}"
        
        if [[ -n "${ZSH_VERSION:-}" ]]; then
            read -q "REPLY?❓ Continue? (y/N) "
            echo
        else
            read -r -p "❓ Continue? (y/N) " REPLY
        fi
        
        if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
            return 1
        fi
        before_bytes=0  # Continue without tracking
    fi
    
    local before_hr
    before_hr=$(numfmt --to=iec --suffix=B "$before_bytes" 2>/dev/null || echo "Unknown")
    echo -e "Current Nix store size: ${BLUE}${before_hr}${NC}"
    log_message "INFO" "Initial store size: $before_hr ($before_bytes bytes)"
    
    # Count profiles and generations for informational purposes
    local profile_count generation_count store_paths
    profile_count=$(find /nix/var/nix/profiles -maxdepth 1 -type l 2>/dev/null | wc -l)
    generation_count=$(sudo nix-env --list-generations 2>/dev/null | wc -l)
    store_paths=$(find /nix/store -maxdepth 1 -type d 2>/dev/null | wc -l)
    
    echo -e "\n${CYAN}📊 System information:${NC}"
    echo -e "  • Profiles: ${profile_count}"
    echo -e "  • Generations: ${generation_count}"
    echo -e "  • Store paths: ${store_paths}"
    
    # Dry run mode check
    if [[ "$DRY_RUN" == "true" ]]; then
        echo -e "\n${YELLOW}🔍 DRY RUN MODE - No changes will be made${NC}"
        log_message "INFO" "Running in dry-run mode"
    fi
    
    # Safety confirmation with detailed warning
    echo -e "\n${RED}${BOLD}⚠️  WARNING: This operation will:${NC}"
    echo -e "  ${YELLOW}• Remove ALL old system generations${NC}"
    echo -e "  ${YELLOW}• Delete unreferenced store paths${NC}"
    echo -e "  ${YELLOW}• Cannot be undone${NC}"
    echo -e "\n${CYAN}💡 Tip: Consider creating a backup first${NC}"
    
    if [[ -n "${ZSH_VERSION:-}" ]]; then
        read -q "REPLY?❓ Proceed with cleanup? (y/N) "
        echo
    else
        read -r -p "❓ Proceed with cleanup? (y/N) " REPLY
    fi
    
    if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
        log_message "INFO" "User cancelled cleanup"
        echo -e "\n${GREEN}✅ Cleanup cancelled. No changes made.${NC}"
        return 0
    fi
    
    echo -e "\n${GREEN}🚀 Starting cleanup operations...${NC}"
    log_message "INFO" "User confirmed cleanup"
    
    # ========================================================================
    # CLEANUP PHASE 1: Remove automatic GC roots (OPTIMIZED)
    # ========================================================================
    
    local auto_roots="/nix/var/nix/gcroots/auto"
    if [[ -d "$auto_roots" ]]; then
        echo -e "\n${YELLOW}[1/4] Removing automatic GC roots...${NC}"
        local roots_count
        roots_count=$(sudo find "$auto_roots" -mindepth 1 -maxdepth 1 2>/dev/null | wc -l)
        
        if (( roots_count > 0 )); then
            log_message "INFO" "Found $roots_count GC roots to remove"
            
            if [[ "$DRY_RUN" != "true" ]]; then
                # Parallel removal with xargs for better performance
                log_message "DEBUG" "Removing broken symlinks in parallel"
                sudo find "$auto_roots" -type l -xtype l -print0 2>/dev/null | \
                    xargs -0 -r -P4 rm -f 2>/dev/null || true
                
                log_message "DEBUG" "Removing remaining GC roots in parallel"
                sudo find "$auto_roots" -mindepth 1 -maxdepth 1 -print0 2>/dev/null | \
                    xargs -0 -r -P4 rm -rf 2>/dev/null || true
            fi
            
            echo -e "${GREEN}  ✓ Removed ${roots_count} GC roots${NC}"
        else
            echo -e "${BLUE}  ✓ No GC roots to remove${NC}"
        fi
    else
        log_message "WARNING" "GC roots directory not found: $auto_roots"
        echo -e "${YELLOW}  ⚠ GC roots directory not found${NC}"
    fi
    
    # ========================================================================
    # CLEANUP PHASE 2: Remove old generations
    # ========================================================================
    
    echo -e "\n${YELLOW}[2/4] Removing old generations...${NC}"
    
    if [[ "$DRY_RUN" != "true" ]]; then
        # Remove user profile generations
        if sudo nix-env --delete-generations old 2>/dev/null; then
            echo -e "${GREEN}  ✓ User generations cleaned${NC}"
            log_message "INFO" "User generations removed"
        else
            echo -e "${YELLOW}  ⚠ No user generations to remove${NC}"
            log_message "INFO" "No user generations found"
        fi
        
        # Remove system profile generations (NixOS specific)
        if [[ -d /nix/var/nix/profiles/system ]]; then
            if sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old 2>/dev/null; then
                echo -e "${GREEN}  ✓ System generations cleaned${NC}"
                log_message "INFO" "System generations removed"
            else
                echo -e "${YELLOW}  ⚠ No system generations to remove${NC}"
                log_message "INFO" "No system generations found"
            fi
        fi
    else
        echo -e "${BLUE}  ⚠ Skipped in dry-run mode${NC}"
    fi
    
    # ========================================================================
    # CLEANUP PHASE 3: Run garbage collection
    # ========================================================================
    
    echo -e "\n${YELLOW}[3/4] Running garbage collection...${NC}"
    log_message "INFO" "Starting garbage collection"
    
    if [[ "$DRY_RUN" != "true" ]]; then
        # Run with delete all generations flag
        local gc_output
        if gc_output=$(sudo nix-collect-garbage -d 2>&1 | tee -a "$LOG_FILE"); then
            # Extract and display freed space
            local freed_info
            freed_info=$(echo "$gc_output" | grep -E "freed|deleted" | head -n 1 || echo "")
            
            if [[ -n "$freed_info" ]]; then
                echo -e "${GREEN}  ✓ $freed_info${NC}"
                log_message "SUCCESS" "Garbage collection: $freed_info"
            else
                echo -e "${GREEN}  ✓ Garbage collection completed${NC}"
                log_message "INFO" "Garbage collection completed"
            fi
        else
            echo -e "${YELLOW}  ⚠ Nothing to collect${NC}"
            log_message "INFO" "No garbage to collect"
        fi
    else
        echo -e "${BLUE}  ⚠ Skipped in dry-run mode${NC}"
    fi
    
    # ========================================================================
    # CLEANUP PHASE 4: Optimize store (deduplication)
    # ========================================================================
    
    echo -e "\n${YELLOW}[4/4] Optimizing store (deduplication)...${NC}"
    log_message "INFO" "Starting store optimization"
    
    if [[ "$DRY_RUN" != "true" ]]; then
        # Store optimization can save significant space via hard links
        local optimize_output
        if optimize_output=$(sudo nix-store --optimise 2>&1); then
            local saved_bytes saved_hr
            
            # Try to extract bytes freed
            saved_bytes=$(echo "$optimize_output" | grep -oP '\d+(?= bytes freed)' || echo "0")
            
            if [[ $saved_bytes -gt 0 ]]; then
                saved_hr=$(numfmt --to=iec --suffix=B "$saved_bytes" 2>/dev/null || echo "${saved_bytes}B")
                echo -e "${GREEN}  ✓ Optimization saved: $saved_hr${NC}"
                log_message "SUCCESS" "Store optimization saved: $saved_hr"
            else
                echo -e "${BLUE}  ✓ Store already optimized${NC}"
                log_message "INFO" "Store already optimized"
            fi
        else
            log_message "WARNING" "Store optimization failed"
            echo -e "${YELLOW}  ⚠ Optimization failed (non-critical)${NC}"
        fi
    else
        echo -e "${BLUE}  ⚠ Skipped in dry-run mode${NC}"
    fi
    
    # ========================================================================
    # RESULTS CALCULATION AND DISPLAY
    # ========================================================================
    
    echo -e "\n${CYAN}📊 Calculating results...${NC}"
    
    # Get final store size
    local after_bytes
    after_bytes=$(get_store_size)
    
    if [[ $after_bytes -eq -1 ]] || [[ $before_bytes -eq 0 ]]; then
        log_message "WARNING" "Could not verify final store size"
        echo -e "\n${CYAN}════════════════════════════════════════${NC}"
        echo -e "${PINK}🎉 CLEANUP COMPLETE!${NC}"
        echo -e "${CYAN}════════════════════════════════════════${NC}"
        echo -e "  ${YELLOW}Size tracking unavailable${NC}"
        echo -e "  ${GREEN}Operations completed successfully${NC}"
        echo -e "${CYAN}════════════════════════════════════════${NC}"
        
        log_message "SUCCESS" "Cleanup completed (size tracking unavailable)"
        echo -e "\n${BLUE}📝 Full log available at: $LOG_FILE${NC}"
        return 0
    fi
    
    # Calculate space saved
    local saved_bytes=$((before_bytes - after_bytes))
    
    # Ensure non-negative value
    if (( saved_bytes < 0 )); then
        saved_bytes=0
        log_message "WARNING" "Store size increased (possibly due to concurrent operations)"
    fi
    
    local after_hr saved_hr
    after_hr=$(numfmt --to=iec --suffix=B "$after_bytes")
    saved_hr=$(numfmt --to=iec --suffix=B "$saved_bytes")
    
    # Calculate percentage saved
    local percent_saved=0
    if (( before_bytes > 0 )); then
        percent_saved=$(( (saved_bytes * 100) / before_bytes ))
    fi
    
    # Display results summary
    echo -e "\n${CYAN}════════════════════════════════════════${NC}"
    echo -e "${PINK}🎉 CLEANUP COMPLETE!${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo -e "  ${BOLD}Before:${NC} ${RED}$before_hr${NC}"
    echo -e "  ${BOLD}After:${NC}  ${GREEN}$after_hr${NC}"
    echo -e "  ${BOLD}Saved:${NC}  ${GREEN}$saved_hr${NC} (${percent_saved}%)"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    
    log_message "SUCCESS" "Cleanup completed. Saved: $saved_hr"
    log_message "INFO" "Final store size: $after_hr ($after_bytes bytes)"
    
    # Send desktop notification if available
    if command -v notify-send >/dev/null 2>&1 && [[ -n "${DISPLAY:-}" ]]; then
        notify-send \
            "Nix Store Cleanup Complete" \
            "Freed $saved_hr (${percent_saved}%)\nNew size: $after_hr" \
            --icon=package-x-generic \
            --urgency=normal \
            2>/dev/null || true
    fi
    
    echo -e "\n${BLUE}📝 Full log available at: $LOG_FILE${NC}"
    
    # Optional: Suggest next steps
    if (( saved_bytes < 104857600 )); then  # Less than 100MB saved
        echo -e "\n${YELLOW}💡 Tip: Consider running 'nix-store --verify --check-contents' to verify store integrity${NC}"
    fi
    
    # Show usage hints
    if [[ "$CHECK_DISK" == "true" ]] || [[ "$DRY_RUN" == "false" ]]; then
        echo -e "\n${CYAN}💡 Performance tips:${NC}"
        [[ "$CHECK_DISK" == "true" ]] && echo -e "  • Skip disk checks: ${BOLD}CHECK_DISK=false $SCRIPT_NAME${NC}"
        [[ "$DRY_RUN" == "false" ]] && echo -e "  • Dry-run mode: ${BOLD}DRY_RUN=true $SCRIPT_NAME${NC}"
        echo -e "  • Debug mode: ${BOLD}DEBUG=true $SCRIPT_NAME${NC}"
    fi
    
    return 0
}

# ============================================================================
# COMMAND ALIASES FOR CONVENIENCE
# ============================================================================

# Register multiple aliases for user convenience
alias Nempty='NIXempty'
alias NIXclean='NIXempty'
alias Nclean='NIXempty'
alias nixclean='NIXempty'
alias nix-clean='NIXempty'

# ============================================================================
# MAIN EXECUTION (if run directly)
# ============================================================================

# Execute if script is run directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    NIXempty "$@"
fi





