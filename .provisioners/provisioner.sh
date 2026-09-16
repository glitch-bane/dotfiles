#!/usr/bin/env bash
set -e

# DEFINE COLORS FOR PRETTY OUTPUT
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NO_COLOR='\033[0m'

# HEADER OUTPUT
echo -e "${GREEN}░░      ░░░  ░░░░░░░░        ░░        ░░░      ░░░  ░░░░  ░░       ░░░░      ░░░   ░░░  ░░        ░"
echo -e "▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒    ▒▒  ▒▒  ▒▒▒▒▒▒▒"
echo -e "▓  ▓▓▓   ▓▓  ▓▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓  ▓▓▓▓▓  ▓▓▓▓▓▓▓▓        ▓▓       ▓▓▓  ▓▓▓▓  ▓▓  ▓  ▓  ▓▓      ▓▓▓"
echo -e "█  ████  ██  ███████████  ████████  █████  ████  ██  ████  ██  ████  ██        ██  ██    ██  ███████"
echo -e "██      ███        ██        █████  ██████      ███  ████  ██       ███  ████  ██  ███   ██        █"
echo -e "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
echo -e "░       ░░░░      ░░░        ░░        ░░        ░░  ░░░░░░░░        ░░░      ░░░░░░░░░░░░░░░░░░░░░░"
echo -e "▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
echo -e "▓  ▓▓▓▓  ▓▓  ▓▓▓▓  ▓▓▓▓▓  ▓▓▓▓▓      ▓▓▓▓▓▓▓  ▓▓▓▓▓  ▓▓▓▓▓▓▓▓      ▓▓▓▓▓      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
echo -e "█  ████  ██  ████  █████  █████  ███████████  █████  ████████  ██████████████  █████████████████████"
echo -e "█       ████      ██████  █████  ████████        ██        ██        ███      ██████████████████████${NO_COLOR}\n"
echo -e "${BLUE}Starting CachyOS / Hyprland Provisioning...${NO_COLOR}\n"

# ASK FOR SUDO UPFRONT
sudo -v

# UPDATE THE SYSTEM
echo -e "${GREEN}Updating system packages...${NO_COLOR}"
sudo pacman -Syu --noconfirm

# INSTALL CORE/SUPPORTING PACKAGES, UNCOMMENT WHEN NEEDED
PACKAGES=(
    "lazygit"
    "obsidian"
)
echo -e "\n${GREEN}Installing core packages...${NO_COLOR}"
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

echo -e "\n${BLUE}PROVISIONING COMPLETE!\nRestart your session to see any changes.${NO_COLOR}"
