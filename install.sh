#!/bin/sh

distro=$(cat /etc/os-release | grep "^NAME=" | cut -d '=' -f 2 | tr -d '"')
username=$(whoami)
echo $distro - $username 

echo "Upgrading packages and installing dependencies";
case "$distro" in
    "Debian GNU/Linux")
        sudo apt update;
        sudo apt upgrade;
        sudo apt install git neovim;
        ;;
    "Arch Linux")
        sudo pacman -Syyyu;
        sudo pacman -S git neovim;
        ;;
    *)
        echo "IDK unu";
        ;;
esac


echo "Creating necessary directories and cloning git repo"
mkdir -p /home/$username/.config/
cd /home/$username/.config/
git clone https://github.com/PenaflorPhi/nvim
