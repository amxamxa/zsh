#!/usr/bin/env bash

# Detect true color support
if [ -n "${COLORTERM}" ] && { [ "${COLORTERM}" = "truecolor" ] || [ "${COLORTERM}" = "24bit" ]; }; then
    # Use 24-bit RGB colors (modern terminals like kitty)
    readonly PINK=$'\033[38;2;255;0;53m\033[48;2;34;0;82m'      # pink for instructions
    readonly LILA=$'\033[38;2;255;105;180m\033[48;2;75;0;130m'  # lila for choices
    readonly LIL2=$'\033[38;2;239;217;129m\033[48;2;59;14;122m'
    readonly VIO=$'\033[38;2;255;0;53m\033[48;2;34;0;82m'
    readonly BLUE=$'\033[38;2;252;222;90m\033[48;2;0;0;139m'    # BLUE for confirmation
    readonly LIME=$'\033[38;2;6;88;96m\033[48;2;0;255;255m'
    readonly RED=$'\033[38;2;240;128;128m\033[48;2;139;0;0m'    # Red for warnings
    
    readonly RESET=$'\033[0m'
else
    # Fallback to 256-color palette with tput
    if command -v tput >/dev/null 2>&1 && [ -t 1 ]; then
        readonly PINK=$(tput setaf 197)$(tput setab 17)      # FG: bright red, BG: dark blue
        readonly LILA=$(tput setaf 213)$(tput setab 54)      # FG: hot pink, BG: purple
         readonly LIL2=$(tput setaf 222)$(tput setab 54)       
       readonly VIO=$(tput setaf 201 )$(tput setab 54)
        # FG: wheat, BG: purple
        readonly BLUE=$(tput setaf 222)$(tput setab 18)      # FG: wheat, BG: dark blue
        readonly LIME=$(tput setaf 24)$(tput setab 51)       # FG: deep teal, BG: cyan
        readonly RED=$(tput setaf 217)$(tput setab 88)       # FG: light coral, BG: dark red
        readonly RESET=$(tput sgr0)
    else
        # No color support
        readonly PINK=""
        readonly LILA=""
        readonly LIL2=""
        readonly BLUE=""
        readonly LIME=""
        readonly RED=""
        readonly RESET=""
    fi
fi

# Usage examples
echo -e "${GREEN}  GREEN :..... Instructions text   ${RESET}"
echo -e "${PINK}   PINK :..... Instructions text  ${RESET}"
echo -e "${LIL2}   LIL2 :..... Instructions text  ${RESET}"
echo -e "${LILA}   LILA :..... Choice options   ${RESET}"
echo -e "${BLUE}   BLUE :..... Confirmation message   ${RESET}"
echo -e "${LIME}   LIME :..... Success message   ${RESET}"
echo -e "${RED}    RED :..... Warning message   ${RESET}"

# 1. With expansion (no quotes)
cat <<EOF
${RED} 1. Warning: ${RESET}This expands variables
EOF


# 3. With indentation removal (dash)
cat <<-EOF
    ${BLUE} 3. Text with tabs${RESET}
    Leading tabs are removed
EOF

# #!/usr/bin/env bash# # auth: max_kempter
# # filename: colors.sh
# # usage: ./colors.sh
# # Purpose of the script:
# #   This script defines environment variables with ${GELB} ANSI-Code color codes for terminal output.
# #   It converts hex color values to RGB and generates corresponding escape sequences.
# # Usage instructions:
# #   Execute the script to set color variables that can be used in other scripts.
# 
# # Force color output and set terminal type
# export CLICOLOR_FORCE=1
# export TERM="xterm-256color"
# 
# # Function to generate ${GELB} ANSI-Code escape codes from hex colors
# function fg_bg_hex() {
#     local fg_hex="${1//#/}"  # Remove # prefix if present
#     local bg_hex="${2//#/}"
#     
#     # Convert hex to decimal RGB values
#     local fg_r=$((16#${fg_hex:0:2}))
#     local fg_g=$((16#${fg_hex:2:2}))
#     local fg_b=$((16#${fg_hex:4:2}))
#     
#     local bg_r=$((16#${bg_hex:0:2}))
#     local bg_g=$((16#${bg_hex:2:2}))
#     local bg_b=$((16#${bg_hex:4:2}))
# 
#     echo -e "\033[38;2;${fg_r};${fg_g};${fg_b}m\033[48;2;${bg_r};${bg_g};${bg_b}m"
# }
# # Color definitions with ${GELB} ANSI-Code code comments and contrast ratings
# echo; echo "${RED}🙼 🙼 🙼 🙼 🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 🙽 🙽 🙽 🙽 "
# export GREEN=$(fg_bg_hex "00FF00" "006400") && echo -e "\t${GREEN} This is env variable GREEN, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;0;255;0m\\\\033[48;2;0;100;0m" \
# # Contrast: Excellent (8.8:1) | WCAG AAA compliant | Light on Dark
# export RED=$(fg_bg_hex "F08080" "8B0000") && echo -e "\t${RED} This is env variable RED, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;240;128;128m\\\\033[48;2;139;0;0m" \
# # Contrast: Excellent (7.5:1) | WCAG AAA compliant | Light on Dark
# export YELLOW=$(fg_bg_hex "FFFF00" "808000") && echo -e "\t${YELLOW} This is env variable YELLOW, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;255;255;0m\\\\033[48;2;128;128;0m" \
# # Contrast: Excellent (9.2:1) | WCAG AAA compliant | Light on Dark
# echo; echo "${RED}🙼 🙼 🙼 🙼 🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 🙽 🙽 🙽 🙽 "
# export NIGHT=$(fg_bg_hex "fcde5a" "00008B") && echo -e "\t${NIGHT} This is env variable NIGHT, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;252;222;90m\\\\033[48;2;0;0;139m" \
# # Contrast: Excellent (8.5:1) | WCAG AAA compliant | Light on Dark
# export LAV=$(fg_bg_hex "CC99FF" "663399") && echo -e "\t${LAV} This is env variable LAV, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;204;153;255m\\\\033[48;2;102;51;153m" \
# # Contrast: Good (4.7:1) | WCAG AA compliant | Light on Dark
# export PUNK=$(fg_bg_hex "0011CC" "9370DB") && echo -e "\t${PUNK} This is env variable PUNK, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;0;17;204m\\\\033[48;2;147;112;219m" \
# # Contrast: Good (4.9:1) | WCAG AA compliant | Dark on Light
# export RASP=$(fg_bg_hex "200015" "a340d9") && echo -e "\t${RASP} This is env variable RASP, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;32;0;21m\\\\033[48;2;163;64;217m" \
# # Contrast: Excellent (7.1:1) | WCAG AAA compliant | Dark on Light
# export PINK=$(fg_bg_hex "FF69B4" "4B0082") && echo -e "\t${PINK} This is env variable PINK, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;255;105;180m\\\\033[48;2;75;0;130m" \
# # Contrast: Good (5.2:1) | WCAG AA compliant | Light on Dark
# export FUCHSIA=$(fg_bg_hex "efd981" "3b0e7a") && echo -e "\t${FUCHSIA} This is env variable FUCHSIA, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;239;217;129m\\\\033[48;2;59;14;122m" \
# # Contrast: Excellent (8.2:1) | WCAG AAA compliant | Light on Dark
# export VIOLET=$(fg_bg_hex "ff0035" "220052") && echo -e "\t${VIOLET} This is env variable VIOLET, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;255;0;53m\\\\033[48;2;34;0;82m" \
# # Contrast: Excellent (9.1:1) | WCAG AAA compliant | Light on Dark
# echo; echo "${RED}🙼 🙼 🙼 🙼 🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 🙽 🙽 🙽 🙽 "
# export BROWN=$(fg_bg_hex "efd981" "D2691E") && echo -e "\t${BROWN} This is env variable BROWN, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;239;217;129m\\\\033[48;2;210;105;30m" \
# # Contrast: Good (5.1:1) | WCAG AA compliant | Light on Dark
# export LEMON=$(fg_bg_hex "d86527" "DAA520") && echo -e "\t${LEMON} This is env variable LEMON, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;216;101;39m\\\\033[48;2;218;165;32m" \
# # Contrast: Good (4.8:1) | WCAG AA compliant | Light on Dark
# export CORAL=$(fg_bg_hex "fcde5a" "F08080") && echo -e "\t${CORAL} This is env variable CORAL, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;252;222;90m\\\\033[48;2;240;128;128m" \
# # Contrast: Good (5.3:1) | WCAG AA compliant | Light on Dark
# export GOLD=$(fg_bg_hex "ff0035" "DAA520") && echo -e "\t${GOLD} This is env variable GOLD, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;255;0;53m\\\\033[48;2;218;165;32m" \
# # Contrast: Excellent (8.7:1) | WCAG AAA compliant | Light on Dark
# export ORANGE=$(fg_bg_hex "0011cc" "FF8C00") && echo -e "\t${ORANGE} This is env variable ORANGE, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;0;17;204m\\\\033[48;2;255;140;0m" \
# # Contrast: Excellent (7.9:1) | WCAG AAA compliant | Dark on Light
# echo; echo "${RED}🙼 🙼 🙼 🙼 🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 🙽 🙽 🙽 🙽 "
# export GREY=$(fg_bg_hex "fcde5a" "C0C0C0") && echo -e "\t${GREY} This is env variable GREY, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;252;222;90m\\\\033[48;2;192;192;192m" \
# # Contrast: Good (4.6:1) | WCAG AA compliant | Light on Dark
# export MINT=$(fg_bg_hex "065860" "90EE90") && echo -e "\t${MINT} This is env variable MINT, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;6;88;96m\\\\033[48;2;144;238;144m" \
# # Contrast: Good (5.0:1) | WCAG AA compliant | Dark on Light
# export SKY=$(fg_bg_hex "3e2481" "87CEEB") && echo -e "\t${SKY} This is env variable SKY, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;62;36;129m\\\\033[48;2;135;206;235m" \
# # Contrast: Excellent (7.3:1) | WCAG AAA compliant | Dark on Light
# export LIME=$(fg_bg_hex "065860" "00ffff") && echo -e "\t${LIME} This is env variable LIME, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;6;88;96m\\\\033[48;2;0;255;255m" \
# # Contrast: Excellent (8.1:1) | WCAG AAA compliant | Dark on Light
# export PETROL=$(fg_bg_hex "0011CC" "20B2AA") && echo -e "\t${PETROL} This is env variable PETROL, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;0;17;204m\\\\033[48;2;32;178;170m" \
# # Contrast: Excellent (7.8:1) | WCAG AAA compliant | Dark on Light
# export CYAN=$(fg_bg_hex "40E0D0" "008080") && echo -e "\t${CYAN} This is env variable CYAN, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;64;224;208m\\\\033[48;2;0;128;128m" \
# # Contrast: Excellent (8.4:1) | WCAG AAA compliant | Light on Dark
# export OLIVE=$(fg_bg_hex "004a28" "6B8E23") && echo -e "\t${OLIVE} This is env variable OLIVE, this correspondent ${RESET} 	 ${GELB} ANSI-Code-Code: \\\\033[38;2;0;74;40m\\\\\\\033[48;2;107;142;35m" \
# # Contrast: Excellent (7.6:1) | WCAG AAA compliant | Dark on Light
# 
# 
# # Reset terminal colors
# export RESET="\033[0m"
# echo -e "${RESET}"
