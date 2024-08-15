#!/bin/sh

DISTRO=$(cat /etc/os-release | grep "^NAME=" | cut -d '=' -f 2 | tr -d '"')
USER=$(whoami)
HOME="/home/$USER/.config"
CONFIG_DIR="$HOME/.config"
NEOVIM_DIR="$CONFIG_DIR/nvim"

echo "$DISTRO" - "$USER"

echo "Upgrading packages and installing dependencies"
case "$DISTRO" in
"Debian GNU/Linux")
    sudo apt update
    sudo apt upgrade
    sudo apt install git neovim
    ;;
"Arch Linux")
    sudo pacman -Syyyu
    sudo pacman -S git neovim
    ;;
*)
    echo "IDK unu"
    ;;
esac

echo "Creating necessary directories and cloning git repo"
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
            echo "Moved neovim configuration to: '$NEW_DIR'"
            break
        fi
        counter=$(expr "$counter" + 1)
    done
fi

cd "$CONFIG_DIR" || exit
git clone https://github.com/PenaflorPhi/nvim
cd "$NEOVIM_DIR" || exit
