#!/usr/bin/env bash

###############################################
# EWW Dashboard - Silent Auto-Install Script
# Asks sudo once at start
###############################################

set -e

# Request sudo at the start and keep it alive
echo "This script requires sudo access for installing dependencies."
sudo -v

# Keep sudo alive in background
while true; do
    sudo -n true
    sleep 50
    kill -0 "$$" || exit
done 2>/dev/null &

# Detect package manager
if command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
elif command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
else
    echo "Error: Unsupported package manager"
    exit 1
fi

echo "Installing dependencies..."

# Install jq and fonts based on package manager
case $PKG_MANAGER in
    pacman)
        sudo pacman -S --needed --noconfirm jq curl ttf-iosevka-nerd ttf-font-awesome
        ;;
    apt)
        sudo apt update
        sudo apt install -y jq curl fonts-font-awesome
        ;;
    dnf)
        sudo dnf install -y jq curl fontawesome-fonts
        ;;
esac

echo "Copying dashboard files..."

# Source directory (where script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/dashboard"

# Create config directory
mkdir -p "$HOME/.config/eww"

# Copy dashboard
cp -r "$SOURCE_DIR" "$HOME/.config/eww/"

# Make scripts executable
chmod +x "$HOME/.config/eww/dashboard/launch_dashboard"
chmod +x "$HOME/.config/eww/dashboard"/scripts/*

# Copy fonts if present
if [ -d "$SCRIPT_DIR/fonts" ]; then
    echo "Installing fonts..."
    mkdir -p "$HOME/.local/share/fonts"
    cp -r "$SCRIPT_DIR/fonts"/* "$HOME/.local/share/fonts/" 2>/dev/null || true
    fc-cache -fv &>/dev/null
fi

# Create cache directories
mkdir -p "$HOME/.cache/eww/weather"

echo "Installation complete!"
echo "Launch with: ~/.config/eww/dashboard/launch_dashboard"
