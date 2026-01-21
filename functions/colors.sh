#!/usr/bin/env bash
# Usage examples - Original colors
echo -e "${PINK}   PINK :..... Instructions text  ${RESET}"
echo -e "${LIL2}   LIL2 :..... Instructions text  ${RESET}"
echo -e "${LILA}   LILA :..... Choice options   ${RESET}"
echo -e "${BLUE}   BLUE :..... Confirmation message   ${RESET}"
echo -e "${LIME}   LIME :..... Success message   ${RESET}"
echo -e "${RED}    RED :..... Warning message   ${RESET}"
echo "# Extended color palette examples:"
cat <<-EOF
	${GOLD}╔════════════════════════════════════╗${RESET}
	${GOLD}║     COLOR SCRIPT USAGE GUIDE       ║${RESET}
    ${GOLD}╚════════════════════════════════════╝${RESET}
	${SKY}▶ IMPORTANT NOTES:${RESET}
	  ${ORANG}• Always end colored text with ${RESET}
	  ${ORANG}• All colors are exported as environment variables${RESET}
	  ${ORANG}• Automatic fallback for terminals without true color support${RESET}
	  ${ORANG}• Colors are readonly to prevent accidental modification${RESET}
	${PETRO}▶ AVAILABLE COLORS  = 28 total):${RESET}
		
	${SKY}▶ 1. BASIC USAGE:${RESET}
	  ${GREY}Source this script to load colors into your shell session:${RESET}
	  ${IVORY}source colors.sh${RESET}
	
	${SKY}2. ▶ IN YOUR SCRIPTS:${RESET}
	  ${GREY}Add at the beginning of your bash script:${RESET}
	  ${IVORY}source "\$(dirname "\$0")/colors.sh"${RESET}
		${SKY}▶ EXAMPLE OUTPUT:${RESET}
     	${CYAN}echo "\${RED}Error: File not found\${RESET}"${RESET}
	  	${CYAN}echo "\${LIME}Success: Operation completed\${RESET}"${RESET}
	  	${CYAN}echo "\${YELLO}Warning: Low disk space\${RESET}"${RESET}
	
  ${SKY}▶ UI/COLOR CATEGORIES:${RESET}
	${PINK}PINK, LILA, LIL2, VIO${RESET}   ${GREY}→ Instructions & Highlights${RESET}
	${BLUE}BLUE, SKY, CYAN${RESET}         ${GREY}→ Confirmations & Info${RESET}
	${LIME}LIME, MINT, TEAL${RESET}        ${GREY}→ Success Messages${RESET}
	${RED}RED, EMBER, RASPB${RESET}        ${GREY}→ Warnings & Errors${RESET}
	${YELLO}YELLO, GOLD, ORANG${RESET}     ${GREY}→ Attention & Caution${RESET}
	${LAVEN}LAVEN,VIOLE,PLUM,INDIG${RESET} ${GREY}→ Special Emphasis${RESET}
	
	${GOLD}═══════════════════════════════════════════════════════════════════════${RESET}

EOF

# Extended color examples
echo "${YELLO}🙼  󱢇  󰧼  󱚡    YELLO - Bright yellow text on dark gold background     󱚡 🙽 ${RESET}"
echo "${LAVEN}🙼  󱢇  󰧼  󱚡    LAVEN - Lavender text on deep purple background    󰧼 󱚡   🙽 ${RESET}"
echo "${PINK2}🙼  󱢇  󰧼  󱚡    PINK2 - Hot pink text on dark rose background    󰧼  󱚡    🙽 ${RESET}"
echo "${RASPB}🙼  󱢇  󰧼  󱚡    RASPB - Raspberry text on dark wine background    󰧼  󱚡   🙽 ${RESET}"
echo "${VIOLE}🙼  󱢇  󰧼  󱚡    VIOLE - Violet text on deep violet background    󰧼  󱚡    🙽 ${RESET}"
cat <<EOF
${PLUM}  🙼  󱚡        PLUM - Plum text on dark plum background    󰧼  󱚡    🙽 🙽    ${RESET}
${BROWN}🙼  󱢇  󰧼  󱚡    BROWN - Brown text on dark brown background    󰧼  󱚡    🙽 🙽 ${RESET}
${IVORY}🙼  󱢇  󰧼  󱚡    IVORY - Ivory text on warm grey background    󰧼  󱚡    🙽 🙽  ${RESET}
${SLATE}🙼  󱢇  󰧼  󱚡    SLATE - Slate text on dark slate background    󰧼  󱚡    🙽 🙽 ${RESET}
${INDIG}🙼  󱢇  󰧼  󱚡    INDIG - Indigo text on deep indigo background    󰧼  󱚡    🙽 ${RESET}
${EMBER}🙼  󱢇  󰧼  󱚡    EMBER - Ember text on dark ember background    󰧼  󱚡    🙽   ${RESET}
EOF

cat <<-EOF
${CORAL}🙼   󱢇  󰧼  󱚡       CORAL - Coral text on muted coral background    󰧼   󱚡  ${RESET}
${ORANG}🙼  󱢇  󰧼  󱚡        ORANG - Orange text on dark orange background󰧼  󱚡  🙽 🙽 ${RESET}
${GOLD}  🙼 🙼 󱢇  󰧼  󱚡      GOLD - Gold text on dark gold background  󰧼  󱚡    🙽 🙽 ${RESET}
${OLIVE}🙼 🙼  󱢇  󰧼  󱚡      OLIVE - Olive text on dark olive background󰧼  󱚡  🙽   🙽 ${RESET}
${CYAN}  🙼 🙼  󱢇  󰧼  󱚡      CYAN - Cyan text on dark cyan background 󰧼  󱚡    🙽 🙽 ${RESET}
${GREY}  🙼 🙼🙼  󱢇  󰧼  󱚡      GREY - Light grey text on dark grey background 󰧼  󱚡 ${RESET}
${TEAL} 🙼 🙼 🙼     󱢇  󰧼  󱚡    TEAL - Teal text on dark teal background  󰧼󱚡🙽   🙽  ${RESET}
${MINT}  🙼  🙼   󱢇  󰧼  󱚡    MINT - Mint text on deep mint background    󰧼   󱚡 🙽  ${RESET}
${SKY}    🙼 🙼  󱢇  󰧼  󱚡    SKY - Sky blue text on dusk blue background  󰧼  󱚡    ${RESET}
EOF

