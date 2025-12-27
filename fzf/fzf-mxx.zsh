# Function: fzf-file-edit
# Keybinding: Ctrl+E
# Purpose: Select file with fzf and open in $EDITOR
# Options:
#   --preview: shows syntax-highlighted file with line numbers
#   --preview-window: places preview at bottom (40% height)
# Output: Opens selected file in $EDITOR

function fzf-file-edit() {
    local files

    files=$(
        fzf --multi \
            --preview 'bat --style=numbers --color=always --line-range :300 {}' \
            --preview-window=down:40% \
            --height=80% \
            --border \
            --prompt='Edit ❯ ' \
            --bind='ctrl-a:select-all,ctrl-d:deselect-all'
    )

    [[ -z "$files" ]] && return 0

    ${EDITOR:-nano} ${(f)files}
}

bindkey '^E' fzf-file-edit

# ────────────────────────────────────────────────
