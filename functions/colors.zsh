#!/usr/bin/env zsh
# filename: colors.zsh
# Purpose of the script:
#   This script defines environment variables with ANSI-Code color codes for terminal output.
#   It uses hardcoded ANSI escape sequences based on RGB values derived from hex colors.
# Usage instructions:
#   Execute the script to set color variables that can be used in other scripts.

# Force color output and set terminal type
export CLICOLOR_FORCE=1
export TERM="xterm-256color"

# Color definitions with hardcoded ANSI escape sequences
export GREEN="\033[38;2;0;255;0m\033[48;2;0;100;0m"       # Hex: 00FF00 (FG), 006400 (BG)
export RED="\033[38;2;240;128;128m\033[48;2;139;0;0m"     # Hex: F08080 (FG), 8B0000 (BG)
export YELLOW="\033[38;2;255;255;0m\033[48;2;128;128;0m"  # Hex: FFFF00 (FG), 808000 (BG)
export NIGHT="\033[38;2;252;222;90m\033[48;2;0;0;139m"    # Hex: fcde5a (FG), 00008B (BG)
export LAV="\033[38;2;204;153;255m\033[48;2;102;51;153m"  # Hex: CC99FF (FG), 663399 (BG)
export PUNK="\033[38;2;0;17;204m\033[48;2;147;112;219m"   # Hex: 0011CC (FG), 9370DB (BG)
export RASP="\033[38;2;32;0;21m\033[48;2;163;64;217m"     # Hex: 200015 (FG), a340d9 (BG)
export PINK="\033[38;2;255;105;180m\033[48;2;75;0;130m"   # Hex: FF69B4 (FG), 4B0082 (BG)
export FUCHSIA="\033[38;2;239;217;129m\033[48;2;59;14;122m" # Hex: efd981 (FG), 3b0e7a (BG)
export VIOLET="\033[38;2;255;0;53m\033[48;2;34;0;82m"     # Hex: ff0035 (FG), 220052 (BG)
export BROWN="\033[38;2;239;217;129m\033[48;2;210;105;30m" # Hex: efd981 (FG), D2691E (BG)
export LEMON="\033[38;2;216;101;39m\033[48;2;218;165;32m" # Hex: d86527 (FG), DAA520 (BG)
export CORAL="\033[38;2;252;222;90m\033[48;2;240;128;128m" # Hex: fcde5a (FG), F08080 (BG)
export GOLD="\033[38;2;255;0;53m\033[48;2;218;165;32m"     # Hex: ff0035 (FG), DAA520 (BG)
export ORANGE="\033[38;2;0;17;204m\033[48;2;255;140;0m"    # Hex: 0011cc (FG), FF8C00 (BG)
export GREY="\033[38;2;252;222;90m\033[48;2;192;192;192m"  # Hex: fcde5a (FG), C0C0C0 (BG)
export MINT="\033[38;2;6;88;96m\033[48;2;144;238;144m"     # Hex: 065860 (FG), 90EE90 (BG)
export SKY="\033[38;2;62;36;129m\033[48;2;135;206;235m"    # Hex: 3e2481 (FG), 87CEEB (BG)
export LIME="\033[38;2;6;88;96m\033[48;2;0;255;255m"       # Hex: 065860 (FG), 00ffff (BG)
export PETROL="\033[38;2;0;17;204m\033[48;2;32;178;170m"   # Hex: 0011CC (FG), 20B2AA (BG)
export CYAN="\033[38;2;64;224;208m\033[48;2;0;128;128m"    # Hex: 40E0D0 (FG), 008080 (BG)
export OLIVE="\033[38;2;0;74;40m\033[48;2;107;142;35m"     # Hex: 004a28 (FG), 6B8E23 (BG)

# Reset terminal colors
export RESET="\033[0m"
