#!/usr/bin/env bash
set -euo pipefail

# DEFINE COLORS FOR PRETTY OUTPUT
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

CONFIG_DIR="$HOME/.config/noctalia"
STATE_DIR="$HOME/.local/state/noctalia"

echo -e "${BLUE}Syncing Noctalia v5 changes into ~/.config repository...${NO_COLOR}"

# ENSURE TRACKED CONFIG DIRECTORY EXISTS
mkdir -p "$CONFIG_DIR"

# EXPORT MERGED CONFIGURATION OR COPY LATEST RUNTIME STATE
if command -v noctalia &>/dev/null; then
    echo -e "${GREEN}Exporting latest Noctalia configuration via CLI...${NO_COLOR}"
    if noctalia config export > "$CONFIG_DIR/config.toml" 2>/dev/null; then
        echo -e "${GREEN}Successfully exported merged config to ~/.config/noctalia/config.toml${NO_COLOR}"
    else
        echo -e "${YELLOW}CLI export command failed. Falling back to state copy...${NO_COLOR}"
        [ -f "$STATE_DIR/settings.toml" ] && cp "$STATE_DIR/settings.toml" "$CONFIG_DIR/settings.toml"
    fi
else
    echo -e "${YELLOW}Noctalia CLI not found. Copying state file directly...${NO_COLOR}"
    if [ -f "$STATE_DIR/settings.toml" ]; then
        cp "$STATE_DIR/settings.toml" "$CONFIG_DIR/settings.toml"
    else
        echo -e "${YELLOW}No local settings file found at $STATE_DIR/settings.toml${NO_COLOR}"
    fi
fi

# 2. Check git status inside ~/.config repo
echo -e "\n${GREEN}Checking git status for noctalia config...${NO_COLOR}"
git -C "$HOME/.config" status -s noctalia/

echo -e "\n${BLUE}SYNC COMPLETE!${NO_COLOR}"
echo -e "Please commit your changes."
echo;
