# Function: fzf-file-edit
# Keybinding: Ctrl+E
# Purpose: Select file with fzf and open in $EDITOR
# Options:
#   --preview: shows syntax-highlighted file with line numbers
#   --preview-window: places preview at bottom (40% height)
# Output: Opens selected file in $EDITOR

function fzf-file-edit() {
    local file

    file=$(
        fzf --preview 'bat --style=numbers --color=always --line-range :300 {}' \
            --preview-window=down:40% \
            --height=80% \
            --border \
            --prompt='Edit ❯ '
    )

    [[ -n "$file" ]] && ${EDITOR:-nano} "$file"
    
    # Redraw the prompt
    zle reset-prompt
}

# Create a zle widget from the function
zle -N fzf-file-edit

# Bind Ctrl+E to the widget
bindkey '^E' fzf-file-edit

# Remove the autoload line since we're defining the function directly
# autoload -Uz fzf-file-edit
# ────────────────────────────────────────────────
