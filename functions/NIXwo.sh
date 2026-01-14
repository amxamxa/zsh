#!/usr/bin/env bash

alias WO = NIXwo.sh
alias NIXwo = NIXwo.sh
    # --- Argument check
    if [ -z "${1:-}" ]; then
        echo "${PINK}Please provide a command name.${RESET}\n"
        return 1
    fi

    cmd="$1"

    # --- Header
    echo "\t ${ORA}NixOS ONLY:${RESET}"
    echo "${SKY} Showing resolved command path, Nix package, and file details.${RESET}\n"

    # --- Resolve via command -v
    cmd_path="$(command -v -- "$cmd" 2>/dev/null || true)"

    if [ -z "$cmd_path" ]; then
        echo "${PINK}Command not found: ${cmd}${RESET}/n"
        return 2
    fi

    echo "${PINK}Resolved via 'command -v':${RESET} $cmd_path"

    # Builtin/function/alias?
    case "$cmd_path" in
        /*) ;;
        *)
            echo "${PINK}Note:${RESET} This command is a shell \n
            builtin, function, or alias."
            return 0
            ;;
    esac

    # --- Resolve symlinks (GNU readlink -f)
    real_path="$(command readlink -f -- "$cmd_path" 2>/dev/null)"
    echo "${ORA}Final resolved file path w/ readlink -f :${RESET} $real_path"

    # --- Nix package derivation (NEW)
    echo "${PINK}Nix package derivation:${RESET}"

    if echo "$real_path" | command grep -q '^/nix/store/'; then
        store_path="$(echo "$real_path" | cut -d/ -f1-4)"
        echo "${BOLD} Store path: $store_path${RESET} "

        # Bindings: derivation info
        if command -v nix-store >/dev/null 2>&1; then
            drv="$(nix-store -q --binding drvPath "$store_path" 2>/dev/null || true)"
            out="$(nix-store -q --binding outPath "$store_path" 2>/dev/null || true)"

            echo "  Derivation:  $drv"
            echo "  Output path: $out"
        else
            echo "  nix-store not found in PATH.\n"
        fi
    else
        echo "  This is NOT a Nix store binary.\n"
    fi

    # --- Size
    echo "\n${VIO}File size (du -h):${RESET}"
    command du -h -- "$real_path" 2>/dev/null || true


