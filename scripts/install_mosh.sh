#!/bin/bash

# Function to install Mosh on Debian
install_mosh_debian() {
    echo "Installing Mosh on Debian-based system..."
    sudo apt-get update
    sudo apt-get install -y mosh
    echo "Mosh installed successfully on Debian."
}

# Function to install Mosh on macOS
install_mosh_macos() {
    echo "Installing Mosh on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Please install Homebrew first."
        exit 1
    fi
    brew install mosh
    echo "Mosh installed successfully on macOS."
}

# Detect OS and install Mosh accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/debian_version ]]; then
            # Debian, Ubuntu, and derivatives
            install_mosh_debian
        else
            echo "Unsupported Linux distribution. This script only supports Debian-based systems."
            exit 1
        fi
        ;;
    Darwin) # macOS
        install_mosh_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

