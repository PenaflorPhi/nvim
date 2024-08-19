#!/bin/sh

# Get the distribution name and current user~ 💻
DISTRO=$(grep "^NAME=" /etc/os-release | cut -d '=' -f 2 | tr -d '"')
USER=$(whoami)
HOME_DIR="/home/$USER"
CONFIG_DIR="$HOME_DIR/.config"
NEOVIM_DIR="$CONFIG_DIR/nvim"

echo "Distro: $DISTRO - User: $USER~ UwU 🎀"

# Update and install dependencies based on the distro 🎉
echo "Upgrading packages and installing dependencies... nya~ 🛠️"
case "$DISTRO" in
    "Debian GNU/Linux")
        sudo apt update && sudo apt upgrade -y
        xargs -a .setup/debian-packages.txt sudo apt install -y
        ;;
    *)
        echo "Unsupported distro... nya~ IDK unu 😿"
        exit 1
        ;;
esac

# Clone and build Neovim from stable branch~ 🐱‍💻✨
echo "Cloning Neovim from GitHub and building it nya~ 💻✨"
git clone https://github.com/neovim/neovim
cd neovim || exit
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
rm -rf neovim

# Backup existing Neovim config if it exists 🎀
echo "Creating necessary directories and managing existing Neovim config nya~ 💾"
if [ -d "$NEOVIM_DIR" ]; then
    counter=0

    while true; do
        NEW_DIR="$CONFIG_DIR/nvim.old${counter:+_$counter}"

        if [ ! -d "$NEW_DIR" ]; then
            mv "$NEOVIM_DIR" "$NEW_DIR"
            echo "Moved Neovim config to: '$NEW_DIR' 🎀"
            break
        fi

        counter=$((counter + 1))
    done
fi

# Move the current directory into the Neovim config directory nya~ 🏠
mkdir -p "$CONFIG_DIR"
mv "$(pwd)" "$NEOVIM_DIR"

echo "Setup completed successfully nya~! UwU 🎀✨"
