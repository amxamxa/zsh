#!/usr/bin/env bash
# =============================================================================
# Script / Function: COPYtoZ
#
# Description:
#   Copies the last command executed in the shell (from history) and appends it
#   to the file $ZDOTDIR/aliases.maybe, then reports success or failure.
#   The command is also printed to stdout for immediate feedback.
#
# Dependencies:
#   - Bash or Zsh (uses 'fc' builtin)
#   - The environment variable ZDOTDIR must be set (typically in Zsh, pointing
#     to the user's Zsh configuration directory). If not set, a clear error
#     message is printed and the function returns 1.
#
# Usage:
#   Source this file or define the function in your shell configuration.
#   Then simply run:
#       COPYtoZ
#
# Exit codes:
#   0 - Command appended successfully.
#   1 - An error occurred (ZDOTDIR missing, history empty, file not writable,
#       or tee failed).
# License: MIT
# =============================================================================

COPYtoZ() {
    # --- Define colour codes if not already set in the environment ---
    # Using tput is more portable, but we provide fallback ANSI codes.
    if ! command -v tput &>/dev/null; then
echo
    else
        local GREEN; GREEN=$(tput setaf 2)   # Green
        local RED;   RED=$(tput setaf 1)     # Red
        local RESET; RESET=$(tput sgr0)      # Reset attributes
    fi

    # --- Validate required environment variable ZDOTDIR ---
    # ZDOTDIR is expected to point to the Zsh configuration directory.
    # If unset or empty, we cannot proceed.
    if [[ -z "${ZDOTDIR:-}" ]]; then
        printf '%bError: ZDOTDIR is not set. Cannot determine target directory.%b\n' \
               "$RED" "$RESET" >&2
        return 1
    fi

    # Build the full path to the aliases file.
    local target_file="${ZDOTDIR}/aliases.maybe"

    # --- Capture the last command from history ---
    # 'fc -ln -1' prints the last history entry without line numbers.
    # We redirect stderr to capture any errors (e.g., empty history).
    local last_command
    if ! last_command=$(fc -ln -1 2>/dev/null) || [[ -z "$last_command" ]]; then
        printf '%bError: Could not retrieve the last command (history may be empty).%b\n' \
               "$RED" "$RESET" >&2
        return 1
    fi

    # --- Check write permission on the target file (or its directory) ---
    # If the file does not exist, we need write permission in the directory.
    if [[ -e "$target_file" ]]; then
        if [[ ! -w "$target_file" ]]; then
            printf '%bError: File %s is not writable.%b\n' \
                   "$RED" "$target_file" "$RESET" >&2
            return 1
        fi
    else
        # File does not exist; check if the parent directory is writable.
        local parent_dir; parent_dir=$(dirname "$target_file")
        if [[ ! -d "$parent_dir" || ! -w "$parent_dir" ]]; then
            printf '%bError: Directory %s does not exist or is not writable.%b\n' \
                   "$RED" "$parent_dir" "$RESET" >&2
            return 1
        fi
    fi

    # --- Append the command to the file and print it ---
    # 'tee -a' appends the input to the file and also writes to stdout.
    # We feed the command via a pipe, and capture tee's exit status.
    # Note: The exit status of a pipeline is the exit status of the last command,
    # which is 'tee' here, so we directly check that.
    printf '%s\n' "$last_command" | tee -a "$target_file"
    local tee_exit=$?

    if [[ $tee_exit -eq 0 ]]; then
        # Success: command appended
        printf '%bCommand %s was successfully appended to %s.%b\n' \
               "$GREEN" "$last_command" "$target_file" "$RESET"
    else
        # Failure: tee exited with non-zero (e.g., disk full, permission changed)
        printf '%bError appending command %s to %s (tee exit code: %d).%b\n' \
               "$RED" "$last_command" "$target_file" "$tee_exit" "$RESET" >&2
        return 1
    fi
}
