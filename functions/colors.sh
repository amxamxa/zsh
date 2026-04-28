#!/usr/bin/env bash
# Usage examples - Original colors
#echo -e "${PINK}   PINK :..... Instructions TXT         ${RESET}"
#echo -e "${LIL2}   LIL2 :..... Instructions TXT accent  ${RESET}"
#echo -e "${BLUE}   BLUE :..... Confirmation message     ${RESET}"
#echo -e "${LILA}   LILA :..... Choice options           ${RESET}"
#echo -e "${GREEN} GREEN :..... Success message           ${RESET}"
#echo -e "${RED}    RED  :..... Warning message           ${RESET}"
#\t'======================================='

echo -e "\t${BLINK} Extended color palette examples:${RESET}
  ${PINK2}╔════════════════════════════════════╗${RESET}
  ${PINK2}║    ${BOLD}COLOR SCRIPT USAGE GUIDE        ║${RESET}
  ${PINK2}╚════════════════════════════════════╝${RESET}"

cat <<-EOF
${ORANG} ▶ Colors are exported as environment variables ${RESET}
${GOLD} ▶ Colors are readonly to prevent modification  ${RESET}
${YELLO} ▶     AVAILABLE COLORS    =    28 total)       ${RESET}

${BOLD}${RASPB}  == IN YOUR SHELL|| SCRIPTS: ==${RESET}
 ${GREY}Add too your script:${RESET}  ${BLUE}source "\$ZDOTDIR/functions/colors.sh"${RESET}
EOF
echo -e "
${BOLD}${RASPB} ▶ USAGE:${RESET}
   \t${RED} echo -e \"\${RED}Error: File not found\${RESET}\" ${RESET}
   \t${GREEN} echo -e \"\${GREEN}Success: Operation completed\${RESET}\" ${RESET}
    \t${IVORY} echo -e \"\${IVORYYELLO}Warning: Low disk space\${RESET}\" ${RESET}
  	 "
  echo -e "
  ${BOLD}${RASPB} 3, ==▶ UI/COLOR CATEGORIES:${RESET}
	${PINK}PINK,${LILA} LILA, ${LIL2}LIL2,${VIO} VIO${RESET}   ${GREY}→ Instructions & Highlights${RESET}
	${BLUE}BLUE, SKY, CYAN${RESET}         ${GREY}→ Confirmations & Info     ${RESET}
	${GREEN}LIME, MINT, TEAL${RESET}        ${GREY}→ Success Messages         ${RESET}
	${RED}RED,${BLINK}${EMBER}EMBER${RESET}            ${GREY}→ Warnings & Errors        ${RESET}
	${YELLO}YELLO, GOLD, ORANG${RESET}      ${GREY}→ Attention & Caution     ${RESET}
	${LAVEN}VIOLE,PLUM,INDIG${RESET}        ${GREY}→ Special Emphasis        ${RESET}
"
sleep 1
#  ${BLINK}
# Extended color examples
#echo -e "${BOLD}🙽  🙽  🙽  🙽  🙽  🙽  🙽  🙽  -  󱢇 - 󰧼 - 󱚡 -  󱢇 - 🙽  🙽  🙽  🙽  🙽  🙽  🙽  🙽   ${RESET}" | lolcat
#echo -e "           🙼 🙼 🙼 . 󱢇  .🙽 🙽 🙽 ${RESET}" | lolcat -f --seed=2 --spread=0.5 --freq=0.17
#echo -e "        🙼 🙼 🙼 🙼 .  󱢇  .    🙽 🙽 🙽 🙽 ${RESET}" | lolcat -f --seed=4 --spread=0.5 --freq=0.3
#echo -e "    🙼 🙼 🙼 🙼 🙼 🙼 .   󱢇   .🙽 🙽 🙽 🙽 🙽 ${RESET}" | lolcat -f --seed=5 --spread=1.43 --freq=0.5
#echo -e "  🙼 🙼 🙼 🙼 🙼 🙼 🙼 .         󱢇     .🙽 🙽 🙽 🙽 🙽 🙽 🙽 ${RESET}" | lolcat -f --seed=6 --spread=0.9 --freq=0.2
#echo -e "\n\n${BOLD}🙽  🙽  🙽  🙽  🙽  🙽  🙽  🙽  -  󱢇 - 󰧼 - 󱚡 - 󱢇 - 🙽  🙽  🙽  🙽  🙽  🙽  🙽  🙽   ${RESET}" | lolcat -f --seed=5 --spread=0.5 --freq=0.2 -a
echo -e "
${PINK}${BOLD}
\t==== __ =======  _ ================== |
\t|   / _|___ __ _| |_ _  _ _ _ ___ ___ |
\t|  |  _/ -_) _  |  _| || | '_/ -_|_-< |
\t|  |_| \___\__,_|\__|\_,_|_| \___/__/ |
\t =====================================${RESET}\n"
# ───────────────────────────
#   GELB / GOLD
echo -e "    ${YELLO}  🙼    YELLO - Bright yellow TXT on gold bg 🙼    ${RESET}"
echo -e "    ${GOLD}  🙼     GOLD  - Gold TXT on dark gold bg    🙼    ${RESET}"
echo -e "    ${IVORY} 🙼    IVORY - Ivory TXT on warm grey bg     🙽    ${RESET}"
# ───────────────────────────
#   ORANGE / CORAL / EMBER
echo -e "    ${ORANG}  🙼  ORANG - Orange TXT on dark orange bg    🙽    ${RESET}"
echo -e "    ${CORAL} 🙼    CORAL - Coral TXT on muted coral bg      🙽    ${RESET}"
echo -e "    ${EMBER} 🙽    EMBER - Ember TXT on dark ember bg       🙼    ${RESET}"
# ───────────────────────────
#   ROT / PINK / RASPBERRY
echo -e "    ${PINK2} 🙼    PINK2 - Hot pink TXT on dark rose bg      🙽    ${RESET}"
echo -e "    ${RASPB} 🙽    RASPB - Raspberry TXT on dark wine bg     🙼    ${RESET}"
# ───────────────────────────
#   VIOLETT / LILA / INDIGO
echo -e "    ${LAVEN}  🙽    LAVEN - Lavender TXT on deep purple bg    🙽    ${RESET}"
echo -e "    ${VIOLE}  🙼    VIOLE - Violet TXT on deep violet bg      🙼    ${RESET}"
echo -e "    ${PLUM}   🙽    PLUM  - Plum TXT on deep plum bg         🙼    ${RESET}"
echo -e "    ${INDIG}  🙼    INDIG - Indigo TXT on deep indigo bg     🙽    ${RESET}"
# ───────────────────────────
#   BLAU / CYAN / TEAL / SKY
echo -e "    ${BLUE} 🙼    BLUE  - Yellow TXT on deep blue bg      🙽    ${RESET}"
echo -e "    ${SKY} 🙼    SKY   - Sky blue TXT on dusk blue bg      🙽    ${RESET}"
echo -e "    ${CYAN}🙽    CYAN  - Cyan TXT on dark cyan bg          🙼    ${RESET}"
echo -e "    ${TEAL}🙼    TEAL  - Teal TXT on dark teal bg          🙽    ${RESET}"
echo -e "    ${NIGHT}🙽    NIGHT - Night blue TXT on deep night bg  🙼    ${RESET}"
# ───────────────────────────
#   GRÜN / OLIVE / MINT
echo -e "    ${GREEN}🙼    GREEN - Green TXT on dark green bg       🙽    ${RESET}"
echo -e "    ${OLIVE}🙽    OLIVE - Olive TXT on dark olive bg      🙽    ${RESET}"
echo -e "    ${MINT} 🙽    MINT  - Mint TXT on deep mint bg         🙽    ${RESET}"
# ───────────────────────────
#   NEUTRAL / ERDE / GRAU
echo -e "    ${BROWN}  🙽    BROWN - Brown TXT on dark brown bg       🙼    ${RESET}"
echo -e "    ${GREY}  🙼    GREY  - Light grey TXT on grey bg       🙼    ${RESET}"
echo -e "     ${SLATE} 🙽    SLATE - Slate TXT on dark slate bg       🙽    ${RESET}"

echo -e "${BOLD}🙽  🙽  🙽  🙽  🙽  🙽  🙽  🙽  -  󱢇 - 󰧼 - 󱚡 - 󱢇 - 🙽  🙽  🙽  🙽  🙽  🙽  🙽  🙽   ${RESET}" | lolcat -f --seed=5 --spread=0.5 --freq=0.2 -a
#echo -e " 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 🙼 ${RESET}" | lolcat -f --seed=5 --spread=0.5 --freq=0.2 -a
#echo -e "  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  🙼  ${RESET}" | lolcat -f --seed=5 --spread=0.5 --freq=0.2 -a

