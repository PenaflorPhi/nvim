#!/bin/sh

# Get the distribution name and current user
DISTRO=$(grep "^NAME=" /etc/os-release | cut -d '=' -f 2 | tr -d '"')
USER=$(whoami)
HOME_DIR="/home/$USER"
CONFIG_DIR="$HOME_DIR/.config"
NEOVIM_DIR="$CONFIG_DIR/nvim"

echo "Distro: $DISTRO - User: $USER"

# Update and install dependencies based on the distro
echo "Upgrading packages and installing dependencies..."
case "$DISTRO" in
"Debian GNU/Linux")
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y git neovim
    ;;
"Arch Linux")
    sudo pacman -Syyu --noconfirm
    sudo pacman -S --noconfirm git neovim
    ;;
*)
    echo "Unsupported distro. IDK unu"
    exit 1
    ;;
esac

# Backup existing Neovim config if it exists
echo "Creating necessary directories and managing existing Neovim config..."
if [ -d "$NEOVIM_DIR" ]; then
    counter=0

    while true; do
        if [ "$counter" -eq 0 ]; then
            NEW_DIR="$CONFIG_DIR/nvim.old"
        else
            NEW_DIR="$CONFIG_DIR/nvim.old_$counter"
        fi

        if [ ! -d "$NEW_DIR" ]; then
            mv "$NEOVIM_DIR" "$NEW_DIR"
            echo "Moved Neovim configuration to: '$NEW_DIR'"
            break
        fi

        counter=$(expr "$counter" + 1)
    done
fi

# Create the config directory and move the current directory into it
mkdir -p "$CONFIG_DIR"
mv "$(pwd)" "$NEOVIM_DIR"
cd "$NEOVIM_DIR" || exit

echo "Setup completed successfully! UwU 🎀"
