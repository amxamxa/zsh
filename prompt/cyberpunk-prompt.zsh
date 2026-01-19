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

 # Enable prompt substitution
setopt prompt_subst

      # Disable Powerlevel10k configuration wizard
           POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

      # Logging helper function
      _log() {
        printf "[%s] %-12s %-5s %s\n" "$(date '+%c')" "$1" "$2" "$3" >> "${ZDOTDIR:-$HOME}/zsh.log" 2>/dev/null
      }

      # Git prompt function (Cyberpunk-Dark-Mode optimized)
      git_prompt_info() {
        local ref branch_status

        # Get current branch or short commit hash
        ref=$(command git symbolic-ref --short HEAD 2>/dev/null) || \
        ref=$(command git rev-parse --short HEAD 2>/dev/null) || return 0

        # Check for uncommitted changes
        branch_status=$(command git status --porcelain 2>/dev/null)

        if [[ -n "$branch_status" ]]; then
          echo "%F{#FF00FF}($ref%f%F{#00FFFF}*)%f"
        else
          echo "%F{#00FFAA}($ref)%f"
        fi
      }

      # Precmd function to cache git info (performance optimization)
      precmd() {
        GIT_PROMPT_CACHE=$(git_prompt_info)
      }

      # Fallback prompt (Cyberpunk-Dark-Mode colors)
      PROMPT='${GIT_PROMPT_CACHE} %F{#00FFFF}%n%f@%F{#FF00FF}%m%f %F{#00FFAA}%~%f %F{#FF55FF}>%f '
      RPROMPT='%F{#FFFF00}%D{%H:%M:%S}%f'

      # Load Powerlevel10k if available
      if [[ -f "${ZDOTDIR:-$HOME}/prompt/p10k.zsh" ]]; then
        source "${ZDOTDIR:-$HOME}/prompt/p10k.zsh" 2>/dev/null && \
        _log INFO "p10k" "Loaded Powerlevel10k" || \
        _log ERROR "p10k" "Failed to load Powerlevel10k"
      fi
      
