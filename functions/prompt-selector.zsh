#!/usr/bin/env zsh

# --------------------------------------------
#		████─████─████─█───█─████─███
#		█──█─█──█─█──█─██─██─█──█──█─
#		████─████─█──█─█─█─█─████──█─
#		█────█─█──█──█─█───█─█─────█─
#		█────█─█──████─█───█─█─────█─
# anderweitig in zsh.nix definiert:
########### Variantze 1: PROMPT Powerlevel10k 
# Enable Powerlevel10k instant prompt. Should stay close to the top of /share/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#     [[ ! -f /run/current-system/sw/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme ]] || source /run/current-system/sw/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit /share/zsh/.p10k.zsh.
# [[ ! -f file.zsh ]] || source file.zsh
 #      [[ ! -f $ZDOTDIR/prompt/p10k.zsh ]] || source $ZDOTDIR/prompt/p10k.zsh
# -f: (Readable): Bedingung evaluiert True, wenn Datei existiert und Nutzer Leseberechtigung hat
# POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# unload prompt $powerlevel10k_plugin_unload
# Logging helper (append-only)
  # $1 = level, , $2 = filename $3 = message
      _log() {
        printf "[%s] %-12s %-5s %s\n" "$(date '+%c')" "$1" "$2" "$3" > "${ZDOTDIR}/log/"$(date +%F)"-zsh-prompt.log"
        }
        
#-----------------------POWERLEVEL PROMPT------------------------------
 # Powerlevel10k laden the ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

[[ -f /run/current-system/sw/share/zsh/themes/zsh-powerlevel10k/powerlevel10k.zsh-theme ]] && source /run/current-system/sw/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

  # Try user-provided powerlevel10k in ZDOTDIR/prompt
      [[ -f $ZDOTDIR/prompt/p10k.zsh ]] && source $ZDOTDIR/prompt/p10k.zsh
        
#----FALLBACK 2:------------------ZSH NATIVE PROMPT-----------------------------
    # powerlevel10k_plugin_unload
   # prompt off
   # setopt prompt_subst
   # autoload -Uz colors && colors
#	export PROMPT='%F{184}%n%f@%F{013}%m%f%F{025}%K{118} in %k%f%F{225}%K{055}%~%f%k%F{063}%K{045} --> %k%f'
#    export RPROMPT='|%F{#FFCA5B}ERR:%?|%F{#CF36E8}%K{#39257D}%f%k%K{#3B0045}%F{#518EA9}%D{%e.%b.}%f%k%F{#FFEAA0}%K{#1E202C}%f%k|%F{#FFEAA0}%K{#95235F}%D{%R}%f%k%F{#FFCA5B}|'
  #  _log WARNING "Using minimal fallback prompt; install starship or powerlevel10k for richer prompt"
#   fi
# fi
     
#----FALLBACK 1:---------------STARSHIP PROMPT----------------------------------
      # Fallback: use starship if p10k not loaded
#      if [[ $p10k_loaded -eq 0 ]]; then
        # Ensure prompt directory exists and is writable before writing config
 #       mkdir -p $ZDOTDIR/prompt 2>/dev/null || true
      # Generate a starship config only if starship is available
  #      if command -v starship >/dev/null 2>&1; then
          # Create a minimal starship config (do not overwrite if user provided one)
   #       if [[ ! -f $ZDOTDIR/prompt/starship.toml ]]; then
    #      starship preset tokyo-night > $ZDOTDIR/prompt/starship.toml
     #     fi
     #     export STARSHIP_CONFIG=$ZDOTDIR/prompt/starship.toml
      #    eval "$(starship init zsh)"
      #    eval "$(starship completions zsh)"
      #    _log INFO "Using starship prompt"
#      else
     # Fallback-Promptzsh.log" 2>/dev/null
      
      
