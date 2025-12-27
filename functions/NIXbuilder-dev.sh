#!/usr/bin/env bash
# auth:______max__kempter_______
# filename:______NIXbuilder.sh

# This script helps you rebuild your NixOS system with different options
# It's designed to be beginner-friendly with clear explanations at each step
#
# What it does:
# 1. Lets you edit configuration files
# 2. Chooses how to build your system (switch immediately, boot later, or test in VM)
# 3. Updates your packages (optional)
# 4. Names your system version
# 5. Builds your new NixOS system
#
# Usage:
# Simply run: sudo ./NIXbuilder.sh

# Define colors for better readability
SKY=" \033[38;2;255;0;53m\033[48;2;34;0;82m"  # Blue for instructions
RED="\033[38;2;240;128;128m\033[48;2;139;0;0m"    # Red for warnings
RAS="\033[38;2;255;105;180m\033[48;2;75;0;130m" # Purple for choices
GREEN="\033[38;2;252;222;90m\033[48;2;0;0;139m" # Green for confirmation
RESET="\033[0m"  # Reset to normal colors

# Configuration files location
NixFiles="/etc/nixos/*.nix"

# Check for administrator rights

# Handle sudo permissions interactively
if [ "$EUID" -ne 0 ]; then
    echo -e "\t${RAS}⚠️ This script requires administrator privileges. ⚠️ ${RESET}"
    echo -e "\t${GREEN}   Requesting sudo permissions interactively...${RESET}"
    exec sudo -k "$0" "$@"
    exit 1
fi

# Countdown function with cancellation option
 countdown() {
    secs=10
    while [ $secs -gt 0 ]; do
        echo -ne "\t⏳ Press Enter to confirm or Ctrl+C to cancel... ($secs)\r"
        read -t 1 && break
        secs=$((secs-1))
    done
    echo -ne "\n"
}

# 1. EDITOR SELECTION
echo -e "\n\t${RAS}📝 STEP 1: Edit Configuration Files (Optional)${RESET}"
read -p "$(echo -e "\n\t${SKY}Open editor? ${RAS}(Enter for Yes, nN for No): ${RESET}")" editor_choice

if [[ "$editor_choice" != "n" && "$editor_choice" != "N" ]]; then
    echo -e "\t${GREEN}Opening configuration files in editor...${RESET}"
    gnome-text-editor --ignore-session --standalone --new-window $NixFiles 2>/dev/null || $EDITOR $NixFiles || nano $NixFiles
else
    echo -e "\t${GREEN}Skipping file editing...${RESET}"
fi
echo

# 2. BUILD METHOD SELECTION
echo -e "\n\t${RAS}⚙️ STEP 2: Choose Build Method${RESET}"
echo -e "\t${RAS}How do you want to apply your new configuration?"
echo -e "\t${SKY}  [s] switch  ${RESET}- Apply immediately (default, safest)"
echo -e "\t${SKY}  [b] boot    ${RESET}- Apply at next reboot (good for major changes)"
echo -e "\t${SKY}  [v] vm      ${RESET}- Build in virtual machine (test without changing real system)${RESET}"
read -p "$(echo -e "\n\t${SKY}Your choice? ${RAS}(s/b/v) [Default: s]: ${RESET}")" build_choice

case $build_choice in
    b) BUILD="boot"; METHOD="Boot at next restart" ;;
    s|"") BUILD="switch"; METHOD="Apply immediately" ;;
    v) BUILD="build-vm"; METHOD="Test in Virtual Machine" ;;
    *) echo -e "\t${RED}❌ Invalid choice. Exiting script.${RESET}"; exit 1 ;;
esac
echo -e "\t${GREEN}Selected: ${RAS}$METHOD${RESET}"
echo

# 3. PACKAGE UPDATE OPTION
echo -e "\n\t${RAS}🔄 STEP 3: Package Updates${RESET}"
echo -e "\t${RAS}Do you want to update your packages before building?"
echo -e "\tThis fetches the latest software versions from NixOS channels${RESET}"
read -p "$(echo -e "\n\t${GREEN}Update packages? ${RAS}(Enter for Yes, n for No): ${RESET}")" upgrade_choice

if [[ "$upgrade_choice" == "n" || "$upgrade_choice" == "N" ]]; then
    UPGRADE=""
    echo -e "\t${GREEN}Keeping current package versions...${RESET}"
else
    UPGRADE="--upgrade"
    echo -e "\t${GREEN}Updating to latest packages...${RESET}"
fi
echo

# 4. SYSTEM VERSION NAMING
echo -e "\n\t${SKY}🏷️ STEP 4: Name Your System Version${RESET}"
default_name=$(date +"%Y-%B")  # Format: 2024-July
echo -e "\t${RAS} this system version a name for identification"
echo -e "\t${RAS}Default name: ${GREEN}$default_name${RESET} (based on current date)"
read -p "$(echo -e "\n\t${GREEN} Yourr custom name or press Enter for default: ${RESET}")" profile_name

NAME=${profile_name:-$default_name}
echo -e "\t${GREEN}System version name: ${RAS}$NAME${RESET}"
echo

# 5. CONFIRMATION BEFORE BUILDING
echo -e "\n\t${SKY}✅ STEP 5: Confirm Settings${RESET}"
echo -e "\t${GREEN}Review your choices before building:"
echo -e "\t${RAS}● Build Method: ${RESET}$METHOD"
echo -e "\t${RAS}● Package Update: ${RESET}$([ -n "$UPGRADE" ] && echo "Yes" || echo "No")"
echo -e "\t${RAS}● Version Name: ${RESET}$NAME"
echo -e "\n\t${GREEN}The following command will be executed:"
echo -e "\t${RAS}sudo nixos-rebuild $BUILD $UPGRADE --show-trace --profile-name \"$NAME\"${RESET}"

countdown

# 6. EXECUTE THE BUILD
echo -e "\n\t${SKY}🚀 Building your NixOS system...${RESET}"
echo -e "\t{SKY} please be patient and don\ interrupt the process${RESET}\n"

sudo nixos-rebuild "$BUILD" --show-trace $UPGRADE --profile-name "$NAME" -I nixos-config=/etc/nixos/configuration.nix

# 7. FINAL FEEDBACK
if [ $? -eq 0 ]; then
    echo -e "\n\t${GREEN}✅ Build successful! Your system is ready${RESET}"
    case $BUILD in
        switch) echo -e "\t${GREEN}Your new configuration is now active${RESET}" ;;
        boot) echo -e "\t${GREEN}Choose ${NAME}' in boot menu at next restart${RESET}" ;;
        build-vm) echo -e "\t${GREEN}Virtual machine built. Test with './result/bin/run-*-vm'${RESET}" ;;
    esac
else
    echo -e "\n\t${RED}❌ Build encountered errors. Check output above${RESET}"
    echo -e "\t${GREEN}Common fixes:"
    echo -e "\t1. Check configuration for syntax errors"
    echo -e "\t2. Ensure internet connection is working"
    echo -e "\t3. Try running with --upgrade if packages are missing${RESET}"
fi
