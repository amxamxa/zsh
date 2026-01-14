#!/usr/bin/env zsh
#################################################
#		╔═╗╦═╗╔═╗╔╦╗╔═╗╔╦╗
#       zsh -	╠═╝╠╦╝║ ║║║║╠═╝ ║ 
#		╩  ╩╚═╚═╝╩ ╩╩   ╩ 
#################################################

# Debugging: 
# zsh -xv, um die Ausführung der Prompt-Funktion zu überprüfen.
# echo $PS1: Zeigt den aktuellen Prompt-String an.

#!!!! " prompt off "  before setting your prompt. 
# otherwise will interact wired w/config
prompt off

# Cyberpunk-Farben (Neon-Palette)
local NEON_PINK="%F{199}"
local NEON_PURPLE="%F{141}"
local NEON_BLUE="%F{75}"
local NEON_GREEN="%F{48}"
local NEON_CYAN="%F{44}"
local RESET="%f"

# Funktion für Cyberpunk-Prompt
function cyberpunk_prompt() {
    # Exit-Status (Neon-Rot bei Fehler)
    local exit_status="%(?..${NEON_PINK}%?${RESET})"

    # Git-Branch + Dirty-Status (Neon-Cyan + Neon-Purple)
    local git_info="\${vcs_info_msg_0_}"
    local git_branch="${NEON_CYAN}\${git_info%% *}${RESET}"
    local git_dirty="${NEON_PURPLE}\${git_info#* }${RESET}"

    # Benutzer@Host (Neon-Grün)
    local user_host="${NEON_GREEN}%n@%m${RESET}"

    # Arbeitsverzeichnis (Neon-Blau)
    local current_dir="${NEON_BLUE}%~${RESET}"

    # Setze PS1 mit Cyberpunk-Design
    PS1="${user_host}:${current_dir} ${exit_status}${git_branch}${git_dirty} ${NEON_PINK}>${RESET} "
}

# VCS-Info für Git-Status (Branch + Dirty-Indicator)
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " %b%m%u%c"
zstyle ':vcs_info:*' actionformats " %b|%a%m%u%c"
precmd() { vcs_info }

# Initialisiere Prompt-System
autoload -Uz promptinit
promptinit
prompt_opts=(cr percent sp subst)
setopt prompt_subst

# Aktiviere Cyberpunk-Prompt
PROMPT='$(cyberpunk_prompt)'
