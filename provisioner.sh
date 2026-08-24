#!/bin/bash
set -e

# DEFINE COLORS FOR PRETTY OUTPUT
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NO_COLOR='\033[0m'
echo -e "${BLUE}Starting CachyOS / Hyprland Provisioning...${NO_COLOR}\n"

# ASK FOR SUDO UPFRONT
sudo -v

# UPDATE THE SYSTEM
echo -e "${GREEN}Updating system packages...${NO_COLOR}"
sudo pacman -Syu --noconfirm

# INSTALL CORE PACKAGES AND GNU STOW
PACKAGES=(
    "stow"
)
echo -e "\n${GREEN}Installing core packages...${NO_COLOR}"
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

# NAVIGATE TO THE SCRIPT DIRECTORY
cd "$(dirname "$0")/configs" || exit

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="$HOME/.dotfiles-backup/$TIMESTAMP"
MODULES=(
    "hypr"
    "noctalia"
    "btop"
    "qt6ct"
    "qt5ct"
    "uwsm"
)

# SYMLINK DOTFILES USING GNU STOW
echo -e "\n${GREEN}Stowing symlink configurations to home directory...${NO_COLOR}"
for MODULE in "${MODULES[@]}"; do

    TARGET="$HOME/.config/${MODULE}"
    echo -e "\n${GREEN}Processing $MODULE ($TARGET)...${NO_COLOR}"

    # BACKUP THE TARGET IF IT EXISTS THEN REMOVE ORIGINAL
    if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
        echo -e "\n${GREEN}  -> Backing up to $BACKUP_DIR...${NO_COLOR}"
        mkdir -p "$BACKUP_DIR"
        cp -r "$TARGET" "$BACKUP_DIR/"

        echo -e "\n${GREEN}  -> Purging $TARGET...${NO_COLOR}"
        rm -rf "$TARGET"
    fi

    # STOW EACH MODULE INTO THE HOME DIRECTORY (-t ~)
    echo -e "\n${GREEN}  -> Stowing $MODULE...${NO_COLOR}"
    stow -v -R -t ~ "$MODULE"
done

echo -e "\n${BLUE}Provisioning Complete! Restart your session to see changes.${NO_COLOR}"
