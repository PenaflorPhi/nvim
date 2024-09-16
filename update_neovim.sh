#!/bin/sh
# Simple script to update neovim

# Check if the neovim directory exists
if [ -d "neovim" ]; then
    cd neovim
    echo "$(pwd)"

    # Ensure we are on the 'stable' branch
    git fetch --all
    git checkout stable || git checkout -b stable origin/stable
    git pull
else
    # Clone the neovim repository if it doesn't exist
    git clone https://github.com/neovim/neovim.git
    cd neovim
    echo "$(pwd)"

    # Check out the stable branch
    git checkout stable || git checkout -b stable origin/stable
    git pull
fi

# Build and install Neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
