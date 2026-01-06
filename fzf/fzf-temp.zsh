#!/usr/bin/env sh
# ───────────────────────────────────────────────────────────────────────────────
# Usage:
#   CTRL+H: Search recursively for a term, fuzzy-select results, preview with context,
#           and open selected files at the matching line.
#   CTRL+T: Select a file with fzf and open it in your editor.
#   CTRL+M
# Example:
#   Press Ctrl+G, type "main", select matches, edit files.
# ───────────────────────────────────────────────────────────────────────────────

# --- Shared Variables ---
#FZF_PREVIEW_OPTS="--preview-window=right:60% --height=80% --border"
FZF_PROMPT="Edit ❯ "
FZF_HEADER="TAB: select • SHIFT-TAB: multi-select • ENTER: open • CTRL-C: cancel"

# --- Safety ---
set -euo pipefail

# ──────────────────────────────────────────────── # Function: grep-fzf-file-edit # Keybinding: Ctrl+G
function grep-fzf-file-edit() {
    # Require a search term
    if [ $# -eq 0 ]; then
        command echo "Usage: grep-fzf-file-edit <search-term>"
        return 1
    fi

    local SEARCH="$1"
    local SEARCH_CMD PREVIEW_CMD EDITOR_CMD

    ############################################################
    # 1. Choose search tool (rg preferred, fallback to grep)
    ############################################################
    if command -v rg >/dev/null 2>&1; then
        # -i = ignore case
        # -n = line numbers
        # --no-heading = cleaner output
        # --hidden = search hidden files
        # --no-ignore = respect .gitignore, but search everything else
        # --type-not binary = exclude binary files
        SEARCH_CMD="command rg -in --line-number --no-heading --hidden --no-ignore --type-not binary \"$SEARCH\" ."
    else
        # grep fallback: exclude binary files
        SEARCH_CMD="command grep -rin --binary-files=without-match \"$SEARCH\" ."
    fi

    ############################################################
    # 2. Choose preview tool (bat preferred, fallback to cat+sed)
    ############################################################
    if command -v bat >/dev/null 2>&1; then
        # bat: show context lines and highlight the matching line
        PREVIEW_CMD="command bat --style=numbers --color=always \
            --line-range {2}-3:{2}+3 --highlight-line {2} {1}"
    else
        # cat+sed fallback: show 3 lines before and after, highlight the matching line
        PREVIEW_CMD="command sed -n \"\$(( {2} - 3 )) , \$(( {2} + 3 ))p\" {1} \
            | command sed \"\$(( 3 + 1 ))s/.*/$(printf '\033[1;31m')&$(printf '\033[0m')/\""
    fi

    ############################################################
    # 3. Choose editor ($EDITOR → micro → vim → nano)
    ############################################################
    if [ -n "${EDITOR:-}" ] && command -v "$EDITOR" >/dev/null 2>&1; then
        EDITOR_CMD="$EDITOR"
    elif command -v micro >/dev/null 2>&1; then
        EDITOR_CMD="micro"
    elif command -v vim >/dev/null 2>&1; then
        EDITOR_CMD="nano"
    else
        EDITOR_CMD="vom"
    fi

    ############################################################
    # 4. Run search → fzf → open selected files at matching lines
    ############################################################
    set +e
    eval "$SEARCH_CMD" \
        | command fzf --multi \
            --header="$FZF_HEADER" \
            --preview="$PREVIEW_CMD" \
            $FZF_PREVIEW_OPTS \
            --prompt="Search: $SEARCH $FZF_PROMPT" \
        | command awk -F: '{print $1 "+" $2}' \
        | command xargs -d '\n' "$EDITOR_CMD"
    set -e

    # Redraw the prompt
    zle reset-prompt
}
# --- Bindings ---
zle -N grep-fzf-file-edit
bindkey '^H' grep-fzf-file-edit

# ──────────────────────────────────────────────── # Function: fzf-file-edit # Keybinding: Ctrl+E
function fzf-file-edit() {
    local file
    file=$(
        fzf --preview 'bat --style=numbers --color=always --line-range :300 {}' \
            $FZF_PREVIEW_OPTS \
            --prompt="$FZF_PROMPT"
    )
    [[ -n "$file" ]] && ${EDITOR:-nano} "$file"

    # Redraw the prompt
    zle reset-prompt
}

# --- Bindings ---
 zle -N fzf-file-edit
bindkey '^E' fzf-file-edit

# ──────────────────────────────────────────────── # Function: fzf-man-page # Keybinding: Ctrl+M
function fzf-man-page() {
    local MAN_PAGE SECTIONS
    SECTIONS=${1:-1 2 3 4 5 6 7 8 9}  # Default: all sections

    # Prompt user for section if argument is "-s"
    if [ "$1" = "-s" ]; then
        SECTIONS=$(
            echo {1..9} | tr ' ' '\n' \
                | command fzf --prompt="Select man section ❯ " --height=40%
        )
        [ -z "$SECTIONS" ] && return  # Cancel if no section selected
    fi

    # Search man pages in selected sections
    local MAN_PAGE
    MAN_PAGE=$(
        command man -k -s "$SECTIONS" . 2>/dev/null \
            | command awk -F': ' '{print $1}' \
            | command fzf --preview '
                command man -P "col -b" {} 2>/dev/null \
                    | command bat --style=numbers,changes --language=man --color=always --paging=never --theme=base16' \
            $FZF_PREVIEW_OPTS \
            --prompt="Man ($SECTIONS) ❯ "
    )
    # Open selected man page in $PAGER (or less if unset)
    if [ -n "$MAN_PAGE" ]; then
        command man "$MAN_PAGE"
        zle reset-prompt
    fi
}
# --- Binding ---
zle -N fzf-man-page
bindkey '^M' fzf-man-page
