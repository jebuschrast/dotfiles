#!/bin/bash

# Function to install btop on Debian
install_btop_debian() {
    echo "Installing btop on Debian-based system..."
    sudo apt-get update
    sudo apt-get install -y btop
    echo "btop installed successfully on Debian."
}

# Function to install btop on macOS
install_btop_macos() {
    echo "Installing btop on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Please install Homebrew first."
        exit 1
    fi
    brew install btop
    echo "btop installed successfully on macOS."
}

# Detect OS and install btop accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/debian_version ]]; then
            # Debian, Ubuntu, and derivatives
            install_btop_debian
        else
            echo "Unsupported Linux distribution. This script only supports Debian-based systems."
            exit 1
        fi
        ;;
    Darwin) # macOS
        install_btop_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

