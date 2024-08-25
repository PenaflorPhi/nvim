#!/bin/sh

# Configuration
GO_VERSION="1.23.0"
INSTALL_DIR="/usr/local/go"
DOWNLOAD_URL="https://go.dev/dl"

# Detect system architecture
if [ "$(uname -m)" = "aarch64" ]; then
    ARCHITECTURE="arm64"
else
    ARCHITECTURE="amd64"
fi

echo "Detected architecture: $ARCHITECTURE"

# Check if Go is already installed and its version
if [ -x "$INSTALL_DIR/bin/go" ]; then
    INSTALLED_VERSION=$($INSTALL_DIR/bin/go version | awk '{print $3}')
    if [ "$INSTALLED_VERSION" = "go$GO_VERSION" ]; then
        echo "Go $GO_VERSION is already installed."
        exit 0
    else
        echo "Different version of Go is installed: $INSTALLED_VERSION. Proceeding with the update."
    fi
else
    echo "Go is not installed. Proceeding with installation."
fi

# Download the specified version of Go
TARBALL="go${GO_VERSION}.linux-${ARCHITECTURE}.tar.gz"
echo "Downloading Go $GO_VERSION for $ARCHITECTURE..."
if ! curl -L -R -O "${DOWNLOAD_URL}/${TARBALL}"; then
    echo "Error: Failed to download Go tarball."
    exit 1
fi

# Remove existing Go installation
echo "Removing existing Go installation..."
sudo rm -rf $INSTALL_DIR

# Extract the new Go version
echo "Installing Go $GO_VERSION..."
if ! sudo tar -C /usr/local -xzf $TARBALL; then
    echo "Error: Failed to extract Go tarball."
    exit 1
fi

# Cleanup the tarball
rm $TARBALL

# Confirm installation and add Go to PATH
if [ -d "$INSTALL_DIR" ]; then
    echo "Go $GO_VERSION installed successfully."
    if ! grep -q '/usr/local/go/bin' ~/.profile; then
        echo "Adding Go to PATH..."
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
        source ~/.profile
    fi
else
    echo "Error: Installation failed."
    exit 1
fi

# Confirm the installation
go version
