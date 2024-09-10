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
# Farb- und Textformatierungsvariablen mit Hex-Farbcodes
export GREEN=$(fg_bg_hex 	"00FF00" "006400")    && echo "\t${GREEN} Das ist env-Variable GREEN"  # Hell auf Dunkel
export RED=$(fg_bg_hex 		"F08080" "8B0000")    && echo "\t${RED} Das ist env-Variable RED"  # Hell auf Dunkel
export YELLOW=$(fg_bg_hex 	"FFFF00" "808000")    && echo "\t${YELLOW} Das ist env-Variable YELLOW"  # Hell auf Dunkel
echo
export FUCHSIA=$(fg_bg_hex 	"FF69B4" "DDA0DD")    && echo "\t${FUCHSIA} Das ist env-Variable FUCHSIA"  # Dunkel auf Hell
export RASPBERRY=$(fg_bg_hex "200015" "DDA0DD")   && echo "\t${RASPBERRY} Das ist env-Variable \tRASPBERRY\t"  # Hell auf Dunkel
export PURPLE=$(fg_bg_hex 	"800080" "DDA0DD")    && echo "\t${PURPLE} Das ist env-Variable \tPURPLE\t"  # Dunkel auf Hell
export PINK=$(fg_bg_hex 	"FF69B4" "4B0082")    && echo "\t${PINK1} Das ist env-Variable PINK"  # Hell auf Dunkel
export PUNK=$(fg_bg_hex 	"574141" "9370DB")    && echo "\t${PINK2} Das ist env-Variable PUNK"  # Dunkel auf Hell
export LAVENDER=$(fg_bg_hex "CC99FF" "663399")    && echo "\t${LAVENDER} Das ist env-Variable LAVENDER"  # Hell auf Dunkel
export WINE=$(fg_bg_hex 	"ca7262" "A020F0")    && echo "\t${WINE} Das ist env-Variable WINE"  # Hell auf Dunkel
export VIOLET=$(fg_bg_hex 	"800080" "4B0082")    && echo "\t${VIOLET} Das ist env-Variable VIOLET"  # Dunkel auf Hell
echo
export BROWN=$(fg_bg_hex 	"A52A2A" "D2691E")    && echo "\t${BROWN} Das ist env-Variable BROWN"  # Dunkel auf Hell
export LEMON=$(fg_bg_hex 	"d86527" "DAA520")    && echo "\t${LEMON} Das ist env-Variable LEMON"  # Dunkel auf Hell
export MAHOGANY=$(fg_bg_hex "C04000" "F08080")    && echo "\t${MAHOGANY} Das ist env-Variable MAHOGANY"  # Dunkel auf Hell
export CORAL=$(fg_bg_hex 	"feed57" "F08080")    && echo "\t${CORAL} Das ist env-Variable CORAL"  # Hell auf Dunkel
export ORANGE=$(fg_bg_hex 	"fcde5a" "FF8C00")    && echo "\t${ORANGE} Das ist env-Variable ORANGE"  # Hell auf Dunkel
export GOLD=$(fg_bg_hex 	"605e4f" "DAA520")    && echo "\t${GOLD} Das ist env-Variable GOLD"  # Dunkel auf Hell
export GRAY=$(fg_bg_hex 	"808080" "C0C0C0")    && echo "\t${GRAY} Das ist env-Variable GRAY"  # Hell auf Dunkel
echo
export MINT=$(fg_bg_hex 	"065860" "90EE90")    && echo "\t${MINT} Das ist env-Variable MINT"  # Dunkel auf Hell
export SKY=$(fg_bg_hex 		"3e2481" "87CEEB")    && echo "\t${SKY} Das ist env-Variable SKY"  # Hell auf Dunkel
export LIME=$(fg_bg_hex 	"065860" "00ffff")    && echo "\t${LIME} Das ist env-Variable LIME"  # Hell auf Dunkel
export PETROL=$(fg_bg_hex 	"008080" "20B2AA")    && echo "\t${PETROL} Das ist env-Variable PETROL"  # Dunkel auf Hell
export CYAN=$(fg_bg_hex 	"40E0D0" "008080")    && echo "\t${CYAN} Das ist env-Variable CYAN"  # Hell auf Dunkel
export OLIVE=$(fg_bg_hex 	"004a28" "6B8E23")    && echo "\t${OLIVE} Das ist env-Variable OLIVE"  # Dunkel auf Hell
export NIGHT=$(fg_bg_hex 	"fcde5a" "00008B")    && echo "\t${NIGHT} Das ist env-Variable NIGHT"  # Hell auf Dunkel


# Übersetzungen de -> en und en -> de
export GRUEN=$GREEN
export ROT=$RED
export GELB=$YELLOW
export PINK_EN=$PINK2
export MINT_DE=$MINT
export VIOLETT=$VIOLET
export NACHTBLAU=$NIGHT
export WEISS=$WHITE
export HIMBEER=$RASPBERRY
export OLIV=$OLIVE

#____________________________________________________________________________________________________________________________
# export CLICOLOR_FORCE=1
# export TERM="rxvt-256color"
# 
# # Farben für Dark Mode anpassen
# export PINK="\033[38;2;219;41;200m\033[48;2;59;0;69m" && echo "\t${PINK} Das ist env-Variable PINK"
# export LILA="\033[38;2;85;85;255m\033[48;2;21;16;46m" && echo "\t${LILA} Das ist env-Variable LILA"
# export GRUEN="\033[38;2;0;255;0m\033[48;2;0;25;2m" && echo "\t${GRUEN} Das ist env-Variable GRUEN"
# export ROT="\033[38;2;240;138;100m\033[48;2;147;18;61m" && echo "\t${ROT} Das ist env-Variable ROT"
# export GELB="\033[38;2;232;197;54m\033[48;2;128;87;0m" && echo "\t${GELB} Das ist env-Variable GELB"
# 
# # Übersetzungen
# export GREEN=$GRUEN
# export RED=$ROT
# export YELLOW=$GELB
# 
# # Weitere Farben mit kürzeren Namen und Umlautanpassung
# export TUERKIS="\033[38;2;64;224;208m\033[48;2;32;178;170m" 	&& echo "\t${TUERKIS} Das ist env-Variable TUERKIS"
# export LAVEND="\033[38;2;204;153;255m\033[48;2;102;51;153m" 	&& echo "\t${LAVEND} Das ist env-Variable LAVEND"
# export KORAL="\033[38;160;71;24;80m\033[48;2;240;128;128m" 		&& echo "\t${KORAL} Das ist env-Variable KORAL"
# export MINT="\033[38;2;0;255;255m\033[48;2;144;238;144m" 		&& echo "\t${MINT} Das ist env-Variable MINT"
# export FUCHSIA="\033[38;2;255;105;180m\033[48;2;221;160;221m" 	&& echo "\t${FUCHSIA} Das ist env-Variable FUCHSIA"
# export OLIV="\033[38;2;128;128;0m\033[48;2;107;142;35m" 		&& echo "\t${OLIV} Das ist env-Variable OLIV"
# export BLAUWEISS="\033[38;2;173;216;230m\033[48;2;135;206;235m" && echo "\t${BLAUWEISS} Das ist env-Variable BLAUWEISS"
# export GOLD="\033[38;2;255;215;0m\033[48;2;218;165;32m" && echo "\t${GOLD} Das ist env-Variable GOLD"
# export NEBELGRAU="\033[38;2;128;128;128m\033[48;2;192;192;192m" && echo "\t${NEBELGRAU} Das ist env-Variable NEBELGRAU"
# export HIMBEER="\033[38;2;255;0;128m\033[48;2;221;160;221m" && echo "\t${HIMBEER} Das ist env-Variable HIMBEER"
# export KAKAO="\033[38;2;165;42;42m\033[48;2;210;105;30m" && echo "\t${KAKAO} Das ist env-Variable KAKAO"
# export LIMETTE="\033[38;2;191;255;0m\033[48;2;144;238;144m" && echo "\t${LIMETTE} Das ist env-Variable LIMETTE"
# export MAHAGONI="\033[38;2;192;64;0m\033[48;2;240;128;128m" && echo "\t${MAHAGONI} Das ist env-Variable MAHAGONI"
# export MINZE="\033[38;2;0;255;255m\033[48;2;144;238;144m" && echo "\t${MINZE} Das ist env-Variable MINZE"
# export NACHTBLAU="\033[38;2;0;0;128m\033[48;2;0;0;139m" && echo "\t${NACHTBLAU} Das ist env-Variable NACHTBLAU"
# export ORANGE="\033[38;2;255;165;0m\033[48;2;255;140;0m" && echo "\t${ORANGE} Das ist env-Variable ORANGE"
# export PETROL="\033[38;2;0;128;128m\033[48;2;32;178;170m" && echo "\t${PETROL} Das ist env-Variable PETROL"
# export PINK="\033[38;2;255;192;203m\033[48;2;221;160;221m" && echo "\t${PINK} Das ist env-Variable PINK"
# export PURPUR="\033[38;2;128;0;128m\033[48;2;75;0;130m" && echo "\t${PURPUR} Das ist env-Variable PURPUR"
# export ROTGELB="\033[38;2;255;215;0m\033[48;2;218;165;32m" && echo "\t${ROTGELB} Das ist env-Variable ROTGELB"
# export SALAT="\033[38;2;0;128;0m\033[48;2;34;139;34m" && echo "\t${SALAT} Das ist env-Variable SALAT"
# export SCHWARZ="\033[38;2;0;0;0m\033[48;2;0;0;0m" && echo "\t${SCHWARZ} Das ist env-Variable SCHWARZ"
# export SILBER="\033[38;2;192;192;192m\033[48;2;128;128;128m" && echo "\t${SILBER} Das ist env-Variable SILBER"
# export TUERKISGRUEN="\033[38;2;64;224;208m\033[48;2;32;178;170m" && echo "\t${TUERKISGRUEN} Das ist env-Variable TUERKISGRUEN"
# export VIOLETT="\033[38;2;128;0;128m\033[48;2;75;0;130m" && echo "\t${VIOLETT} Das ist env-Variable VIOLETT"
# export WEINROT="\033[38;2;139;0;0m\033[48;2;160;32;240m" && echo "\t${WEINROT} Das ist env-Variable WEINROT"
# export WEISS="\033[38;2;255;255;255m\033[48;2;245;245;245m" && echo "\t${WEISS} Das ist env-Variable WEISS"
# export ZITRONE="\033[38;2;255;215;0m\033[48;2;218;165;32m" && echo "\t${ZITRONE} Das ist env-Variable ZITRONE"
# 
# # Übersetzungen für neue Farben
# export TURQUOISE=$TUERKIS
# export LAVEND=$LAVENDEL
# export CORAL=$KORAL
# export OLIVE=$OLIV
# export BLUE-l=$BLAU-l
# export GRAY-l=$GRAU-l
# export RASPBERRY=$HIMBEER
# export COCOA=$KAKAO
# export LIME=$LIMETTE
# export MAHOGANY=$MAHAGONI
# export MINT=$MINZE
# export NAVYBLUE=$NACHTBLAU
# export PETROL=$PETROL
# export PINK=$PINK
# export PURPLE=$PURPUR
# export AMBER=$ROTGELB
# export LETTUCE=$SALAT
# export SILVER=$SILBER
# export TURQUOISEGREEN=$TUERKISGRUEN
# export VIOLET=$VIOLETT
# export WINERED=$WEINROT
# export WHITE=$WEISS
# export LEMON=$ZITRONE
