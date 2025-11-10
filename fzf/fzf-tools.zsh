#!/usr/bin/env zsh

#########################################################################
#///////////////////////////////////////////////////////////////////////#
#//////                                                          ///////#
#////// Name: FZF-Tools                                          ///////#
#////// File: fzf-tools.zsh                                      ///////#
#////// Author: amxamxa happycod3r                               ///////#
#////// Use: Integrates FZF into the command line and much more. ///////#
#////// Check out the README.md for all of the documentation.    ///////#
#//////                                                          ///////#       
#///////////////////////////////////////////////////////////////////////#       
#########################################################################


# Initialize fzf
if [[ -x "$(command -v fzf)" ]]; then
 #export FZF_DEFAULT_COMMAND='ag -g ""'
 #export FZF_DEFAULT_OPTS='-m --preview-window=up:40%:wrap'
source <(fzf --zsh) # Syntax 4  zsh
# Molokai   'fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81,info:144,prompt:161,spinner:135,pointer:135,marker:118'
# oder Synthwave Cold 
export FZF_COLORS="bg+:#1a1a1a,bg:#131313,spinner:#ff69b4,hl:#ff99cc,fg:#ffa07a,header:#ff0033,info:#ffd700,pointer:#ff69b4,marker:#ff0033,prompt:#ffd700,hl+:#ff99cc,gutter:#ff0033"
#export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS="--color=${FZF_COLORS} --preview-window=up:40%:wrap --height=60% --info=inline --margin=5%,2%,2%,2% --border=rounded --prompt='∷  ' --pointer='❯ ' --marker='☭  '"






# === 1. Command Widget (Enhanced) ===
function fzf-command-widget() {
    local full_command="$BUFFER"

    case "$full_command" in
        ls*)
            BUFFER="$full_command | fzf --multi --cycle --no-sort --preview='echo {}' --preview-window down:10% --layout='reverse-list'"
        ;;
        man*)
            BUFFER="fzf-man"
        ;;
        printenv*|env*)
            BUFFER="$full_command | fzf --multi --cycle --no-sort --preview='echo {}' --preview-window down:10% --layout='reverse-list'"
        ;;
        set*)
            BUFFER="$full_command | fzf --multi --cycle --no-sort --preview='echo {}' --preview-window down:10% --layout='reverse-list'"
        ;;
        grep*)
            BUFFER="$full_command | fzf -i --multi --cycle --no-sort --preview='echo {}' --preview-window down:10% --layout='reverse-list'"
        ;;
        find*)
            BUFFER="$full_command | fzf -i --multi --cycle --no-sort --preview='echo {}' --preview-window down:10% --layout='reverse-list'"
        ;;
        'ps aux')
            BUFFER="$full_command | fzf --multi --cycle --no-sort --preview='echo {}' --preview-window down:10% --layout='reverse-list'"
        ;;
    esac
    zle accept-line
}

zle -N fzf-command-widget
bindkey '^M' fzf-command-widget

# === 2. Man Page Widget ===
function fzf-man-widget() {
    local selected_command
    selected_command=$(man -k . | awk '{print $1}' | sort | uniq | fzf \
        --multi \
        --cycle \
        --preview='man {}' \
        --preview-window=right:70%:wrap
    )

    if [[ -n "$selected_command" ]]; then
        BUFFER="man $selected_command"
        zle accept-line
    fi
}

zle -N fzf-man-widget
bindkey '^H' fzf-man-widget

# === 3. Run Command from History ===
function fzf-run-cmd-from-history() {
    local selected_command
    selected_command=$(fc -l 1 | awk '{$1=""; print $0}' | awk '!x[$0]++' | fzf \
        --cycle \
        --tac \
        --no-sort \
        --preview='echo {}' \
        --preview-window=down:10%
    )

    if [[ -n "$selected_command" ]]; then
        eval "$selected_command"
    fi
}

alias fzhist='fzf-run-cmd-from-history'

# === 4. Execute Scripts ===
function fzf-exec-scripts() {
    local directory="$1"
    shift
    local file_exts=("$@")

    if [[ -z "$directory" || "${#file_exts[@]}" -eq 0 ]]; then
        echo "Usage: fzf-exec-scripts <directory> <file_extension1> [<file_extension2> ...]"
        return 1
    fi

    # Build find command with multiple extensions
    local find_cmd="find '$directory' -type f \\( -name '*.${file_exts[1]}'"
    for ext in "${file_exts[@]:1}"; do
        find_cmd+=" -o -name '*.$ext'"
    done
    find_cmd+=" \\)"

    local selected_scripts
    selected_scripts=$(eval "$find_cmd" | fzf \
        --multi \
        --cycle \
        --tac \
        --no-sort \
        --preview='bat --color=always --style=numbers {}' \
        --preview-window=right:60%:wrap \
        --layout='reverse-list'
    )

    if [[ -z "$selected_scripts" ]]; then
        echo "No scripts selected."
        return
    fi

    # Execute each selected script
    while IFS= read -r script; do
        chmod +x "$script"
        
        case "$script" in
            *.sh|*.bash)
                bash "$script"
            ;;
            *.zsh)
                zsh "$script"
            ;;
            *.js)
                node "$script"
            ;;
            *.py)
                python "$script"
            ;;
            *.rb)
                ruby "$script"
            ;;
            *.rs)
                local filename=$(basename "$script" .rs)
                rustc "$script" -o "/tmp/$filename" && "/tmp/$filename"
            ;;
            *)
                echo "Unsupported file type: $script"
            ;;
        esac
    done <<< "$selected_scripts"
}

alias fzscripts='fzf-exec-scripts'

# === 5. Search Files on Path ===
function fzf-search-files-on-path() {
    local _path="${1:-.}"
    
    if command -v fd &> /dev/null; then
        fd --type f . "$_path" | fzf \
            -i \
            --multi \
            --cycle \
            --preview='bat --color=always --style=numbers {}' \
            --preview-window=right:60%:wrap \
            --bind='ctrl-e:execute($EDITOR {})'
    else
        find "$_path" -type f | fzf \
            -i \
            --multi \
            --cycle \
            --preview='bat --color=always --style=numbers {}' \
            --preview-window=right:60%:wrap \
            --bind='ctrl-e:execute($EDITOR {})'
    fi
}

alias fzfop='fzf-search-files-on-path'

# === 6. Git Log Viewer ===
function fzf-git-log() {
    local selected_commit
    selected_commit=$(git log --oneline --color=always | fzf \
        --ansi \
        --multi \
        --no-sort \
        --cycle \
        --preview='git show --color=always {1}' \
        --preview-window=right:60%:wrap \
        --layout='reverse-list'
    )

    if [[ -n "$selected_commit" ]]; then
        local commit_hash=$(echo "$selected_commit" | awk '{print $1}')
        git show "$commit_hash"
    fi
}

alias fzgl='fzf-git-log'

# === 7. Silver Searcher (ag) Integration ===
function fzf-ag() {
    if ! command -v ag &> /dev/null; then
        echo "Error: ag (The Silver Searcher) is not installed"
        return 1
    fi

    local pattern="$1"
    if [[ -z "$pattern" ]]; then
        echo "Usage: fzf-ag <search_pattern>"
        return 1
    fi

    local selected_file
    selected_file=$(ag "$pattern" . | fzf \
        --multi \
        --no-sort \
        --cycle \
        --delimiter=':' \
        --preview='bat --color=always --style=numbers --highlight-line {2} {1}' \
        --preview-window=right:60%:wrap:+{2}/2 \
        --layout='reverse-list' \
        | cut -d: -f1
    )

    if [[ -n "$selected_file" ]]; then
        $EDITOR "$selected_file"
    fi
}

alias fzag='fzf-ag'

# === 8. Docker Container Logs ===
function fzf-docker-ps() {
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed"
        return 1
    fi

    local selected_container
    selected_container=$(docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}" | \
        tail -n +2 | \
        fzf \
            --multi \
            --no-sort \
            --cycle \
            --preview='docker logs --tail=100 {1}' \
            --preview-window=down:60%:wrap \
            --layout='reverse-list' \
        | awk '{print $1}'
    )

    if [[ -n "$selected_container" ]]; then
        docker logs -f "$selected_container"
    fi
}

alias fzdps='fzf-docker-ps'

# === 9. SSH Host Selector ===
function fzf-ssh() {
    if [[ ! -f ~/.ssh/known_hosts ]]; then
        echo "Error: ~/.ssh/known_hosts not found"
        return 1
    fi

    local selected_host
    selected_host=$(cat ~/.ssh/known_hosts | \
        cut -f1 -d' ' | \
        sed -e 's/,.*//g' | \
        uniq | \
        fzf \
            --multi \
            --no-sort \
            --cycle \
            --preview='echo "Host: {}"' \
            --preview-window=down:10% \
            --layout='reverse-list'
    )

    if [[ -n "$selected_host" ]]; then
        ssh "$selected_host"
    fi
}

alias fzssh='fzf-ssh'

# === 10. Recursive Grep with Editor ===
function fzf-grep() {
    local pattern="$1"
    if [[ -z "$pattern" ]]; then
        echo "Usage: fzf-grep <search_pattern>"
        return 1
    fi

    local selected_file
    selected_file=$(grep -Ril "$pattern" . 2>/dev/null | fzf \
        --multi \
        --no-sort \
        --cycle \
        --preview="grep -n '$pattern' {} | head -100" \
        --preview-window=down:60%:wrap \
        --layout='reverse-list'
    )

    if [[ -n "$selected_file" ]]; then
        $EDITOR "$selected_file"
    fi
}

alias fzgrep='fzf-grep'

# === 11. Find Files and Edit ===
function fzf-find() {
    local selected_file
    
    if command -v fd &> /dev/null; then
        selected_file=$(fd --type f | fzf \
            --multi \
            --no-sort \
            --cycle \
            --preview='bat --color=always --style=numbers {}' \
            --preview-window=right:60%:wrap \
            --layout='reverse-list'
        )
    else
        selected_file=$(find . -type f | fzf \
            --multi \
            --no-sort \
            --cycle \
            --preview='bat --color=always --style=numbers {}' \
            --preview-window=right:60%:wrap \
            --layout='reverse-list'
        )
    fi

    if [[ -n "$selected_file" ]]; then
        $EDITOR "$selected_file"
    fi
}

alias fzfind='fzf-find'

# === Autoload Functions ===
autoload -Uz \
    fzf-command-widget \
    fzf-man-widget \
    fzf-run-cmd-from-history \
    fzf-exec-scripts \
    fzf-search-files-on-path \
    fzf-git-log \
    fzf-ag \
    fzf-docker-ps \
    fzf-ssh \
    fzf-grep \
    fzf-find



