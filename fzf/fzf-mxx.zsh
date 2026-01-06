#!/usr/bin/env zsh

# FZF configuration
FZF_PROMPT="Edit ❯ "
FZF_HEADER="TAB: select • SHIFT-TAB: multi-select • ENTER: open • CTRL-C: cancel"

# =================
# FZF File Editor Widget
# ==================

function fzf-file-edit() {
    local file
    file=$(
        fzf --preview 'bat --style=numbers --color=always --line-range :300 {}' \
            --header="$FZF_HEADER" \
            --prompt="$FZF_PROMPT"
    )
    
    if [[ -n "$file" ]]; then
        ${EDITOR:-nano} "$file"
    fi
    
    zle reset-prompt
}

zle -N fzf-file-edit
bindkey '^E' fzf-file-edit

# =================
# FZF Man Page Viewer Widget
# ==================

function fzf-man-page() {
    local MAN_PAGE SECTIONS
    SECTIONS=${1:-1 2 3 4 5 6 7 8 9}
    
    # Section selection with -s flag
    if [[ "$1" == "-s" ]]; then
        SECTIONS=$(
            echo {1..9} | tr ' ' '\n' \
                | fzf --prompt="Select man section ❯ " --height=40%
        )
        [[ -z "$SECTIONS" ]] && return
    fi
    
    # Find and preview man pages
    MAN_PAGE=$(
        command man -k -s "$SECTIONS" . 2>/dev/null \
            | awk -F': ' '{print $1}' \
            | fzf --preview 'man -P "col -b" {} 2>/dev/null \
                | command bat --style=numbers,changes --language=man --color=always --paging=never --theme=base16' \
            --header="$FZF_HEADER" \
            --prompt="Man ($SECTIONS) ❯ "
    )
    
    if [[ -n "$MAN_PAGE" ]]; then
        man "$MAN_PAGE"
    fi
    
    zle reset-prompt
}

zle -N fzf-man-page

# CRITICAL FIX: ^M is ENTER key - don't override it!
# Use different keybinding
bindkey '^[m' fzf-man-page  # Alt+M instead of Ctrl+M
