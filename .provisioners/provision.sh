#!/usr/bin/env bash
set -euo pipefail

# DEFINE COLORS FOR PRETTY OUTPUT
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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
echo -e "${BLUE}Starting CachyOS / Hyprland Provisioning and Update...${NO_COLOR}\n"

# ASK FOR SUDO UPFRONT
sudo -v

# PRE-UPDATE SNAPSHOT SAFEGUARD (BTRFS/SNAPPER ONLY)
if command -v snapper &>/dev/null && snapper list-configs &>/dev/null; then
    echo -e "${YELLOW}Creating automated pre-update Btrfs snapshot...${NO_COLOR}"
    sudo snapper create --description "Pre-update checkpoint $(date +%Y%m%d-%H%M%S)" --cleanup-algorithm "number"
else
    echo -e "${YELLOW}Note: Snapper not configured. Proceeding without auto-snapshot.${NO_COLOR}"
fi

# SAFE & IDEMPOTENT SYSTEM UPDATE
echo -e "${GREEN}Optimizing mirrors...${NO_COLOR}"
if command -v cachyos-rate-mirrors &>/dev/null; then
    sudo cachyos-rate-mirrors || echo -e "${YELLOW}Mirror rating skipped, using current mirrors.${NO_COLOR}"
fi

echo -e "${GREEN}Running system synchronization...${NO_COLOR}"
sudo pacman -Syu

# CORE SOFTWARE PACKAGES
PACKAGES=(
    "lazygit"
    "obsidian"
)

echo -e "\n${GREEN}Checking and installing core packages...${NO_COLOR}"
sudo pacman -S --needed "${PACKAGES[@]}"

# ONE-OFF INSTALLERS
curl -fsSL https://emeraldian-tui.github.io/install.sh | sh

# CLEAR ANY PRE-EXISTING STATE OVERRIDES SO NOCTALIA BOOTS STRICTLY FROM ~/.config
rm -f "$HOME/.local/state/noctalia/settings.toml"

echo -e "\n${BLUE}PROVISIONING COMPLETE!\nEnvironment is up to date.${NO_COLOR}"
