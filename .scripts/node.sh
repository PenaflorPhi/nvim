#!/bin/sh

# Install nvm
echo "Installing nvm..."
if ! curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash; then
    echo "Error: Failed to install nvm."
    exit 1
fi

# Set NVM_DIR and load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
else
    echo "Error: nvm.sh not found. Please check your nvm installation."
    exit 1
fi

# Install Node.js version 20
echo "Installing Node.js v20..."
if ! nvm install 20; then
    echo "Error: Failed to install Node.js v20."
    exit 1
fi

# Check Node.js and npm versions
echo "Checking Node.js and npm versions..."
if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    echo "Node.js version: $(node -v)"
    echo "npm version: $(npm -v)"
else
    echo "Error: Node.js or npm installation failed."
    exit 1
fi

echo "nvm, Node.js, and npm installed successfully!"
