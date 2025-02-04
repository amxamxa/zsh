#!/usr/bin/env zsh

export CLICOLOR_FORCE=1
export TERM="xterm-256color"

# Funktion zur Generierung von Escape-Sequenzen aus Hex- in r,b,g-Farbwerten
function fg_bg_hex() {
    local fg_hex="$1"
    local bg_hex="$2"
    local fg_r=$((16#${fg_hex:0:2}))
    local fg_g=$((16#${fg_hex:2:2}))
    local fg_b=$((16#${fg_hex:4:2}))
    local bg_r=$((16#${bg_hex:0:2}))
    local bg_g=$((16#${bg_hex:2:2}))
    local bg_b=$((16#${bg_hex:4:2}))
    echo "\033[38;2;${fg_r};${fg_g};${fg_b}m\033[48;2;${bg_r};${bg_g};${bg_b}m"
}

# Funktion zur Generierung von Escape-Sequenzen mit r, g, b-Farben
function fg_bg_rgb() {
    local fg_r="$1"
    local fg_g="$2"
    local fg_b="$3"
    local bg_r="$4"
    local bg_g="$5"
    local bg_b="$6"
    echo "\033[38;2;${fg_r};${fg_g};${fg_b}m\033[48;2;${bg_r};${bg_g};${bg_b}m"
}
export VIOLET=$(fg_bg_hex 	"ff0035" "4B0082")  
# Farb- und Textformatierungsvariablen mit Hex-Farbcodes
echo "${VIOLET}\n🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 "
export GREEN=$(fg_bg_hex 	"00FF00" "006400")    && echo "\t${GREEN}  Das ist env-Variable GREEN"
export RED=$(fg_bg_hex 		"F08080" "8B0000")    && echo "\t${RED} 󱢇  Das ist env-Variable RED 󱢇 "  # Hell auf Dunkel
export YELLOW=$(fg_bg_hex 	"FFFF00" "808000")    && echo "\t${YELLOW} Das ist env-Variable YELLOW"  # Hell auf Dunkel

echo "${RED}\n🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 "
export PURPLE=$(fg_bg_hex 	"800080" "DDA0DD")    && echo "\t${PURPLE} Das ist env-Variable PURPLE\t"  # Dunkel auf Hell
export LAV=$(fg_bg_hex "CC99FF" "663399")    && echo "\t${LAV} Das ist env-Variable LAV"  # Hell auf Dunkel
export WINE=$(fg_bg_hex 	"DDa0dd" "A020F0")    && echo "\t${WINE} Das ist env-Variable WINE"  # Hell auf Dunkel
export PUNK=$(fg_bg_hex 	"0011CC" "9370DB")    && echo "\t${PUNK} Das ist env-Variable PUNK"  # Dunkel auf Hell
export RASP=$(fg_bg_hex "200015" "a340d9")   && echo "\t${RASP} Das ist env-Variable RASP\t"  #RASPBERRY
export PINK=$(fg_bg_hex 	"FF69B4" "4B0082")    && echo "\t${PINK} Das ist env-Variable PINK"  # Hell auf Dunkel
export FUCHSIA=$(fg_bg_hex 	"efd981" "3b0e7a")    && echo "\t${FUCHSIA} Das ist env-Variable FUCHSIA"  # Dunkel auf Hell
export VIOLET=$(fg_bg_hex 	"ff0035" "220052")    && echo "\t${VIOLET} Das ist env-Variable VIOLET"  # Dunkel auf Hell

echo "${LAV}\n🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 "
export BROWN=$(fg_bg_hex 	"efd981" "D2691E")    && echo "\t${BROWN} Das ist env-Variable BROWN"  # Dunkel auf Hell
export LEMON=$(fg_bg_hex 	"d86527" "DAA520")    && echo "\t${LEMON} Das ist env-Variable LEMON"  # Dunkel auf Hell
export CORAL=$(fg_bg_hex 	"fcde5a" "F08080")    && echo "\t${CORAL} Das ist env-Variable CORAL"  # Hell auf Dunkel
export GOLD=$(fg_bg_hex 	"ff0035" "DAA520")    && echo "\t${GOLD} Das ist env-Variable GOLD"  # Dunkel auf Hell
export ORANGE=$(fg_bg_hex 	"0011cc" "FF8C00")    && echo "\t${ORANGE} Das ist env-Variable ORANGE"  # Hell auf Dunkel
export MAHO=$(fg_bg_hex 	"ff9a55" "753407")   && echo "\t${MAHO} Das ist env-Variable MAHO"  # Dunkel auf Hell

echo "${ORANGE}\n🙼 🙼  󱢇  󰧼  󱚡    󰧼  󱚡    󰧼  󱚡     󰧼  󱚡    🙽 🙽 "
export GREY=$(fg_bg_hex 	"fcde5a" "C0C0C0")    && echo "\t${GRAY} Das ist env-Variable GREY"  # Hell auf Dunkel
export MINT=$(fg_bg_hex 	"065860" "90EE90")    && echo "\t${MINT} Das ist env-Variable MINT"  # Dunkel auf Hell
export SKY=$(fg_bg_hex 		"3e2481" "87CEEB")    && echo "\t${SKY} Das ist env-Variable SKY"  # Hell auf Dunkel
export LIME=$(fg_bg_hex 	"065860" "00ffff")    && echo "\t${LIME} Das ist env-Variable LIME"  # Hell auf Dunkel
export PETROL=$(fg_bg_hex 	"0011CC" "20B2AA")    && echo "\t${PETROL} Das ist env-Variable PETROL"  # Dunkel auf Hell
export CYAN=$(fg_bg_hex 	"40E0D0" "008080")    && echo "\t${CYAN} Das ist env-Variable CYAN"  # Hell auf Dunkel
export OLIVE=$(fg_bg_hex 	"004a28" "6B8E23")    && echo "\t${OLIVE} Das ist env-Variable OLIVE"  # Dunkel auf Hell
export NIGHT=$(fg_bg_hex 	"fcde5a" "00008B")    && echo "\t${NIGHT} Das ist env-Variable NIGHT${RESET} \t"

# Farb- und Textformatierungsvariablen mit r, g, b-Farben
#export OLIVE=$(fg_bg_rgb 0 74 40 107 142 35) && echo "\t${OLIVE} Das ist OLIVE"
#export NIGHT=$(fg_bg_rgb 252 222 90 0 0 139) && echo "\t${NIGHT} Das ist NIGHT"

# Übersetzungen de -> en und en -> de
export GRUEN=$GREEN
export ROT=$RED
export GELB=$YELLOW
export VIOLETT=$PURPLE
export NACHTBLAU=$NIGHT
export HIMBEER=$FUCHSIA
export OLIV=$OLIVE
