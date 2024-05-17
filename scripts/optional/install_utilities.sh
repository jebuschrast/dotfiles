#!/bin/bash

# Function to install utilities on Debian-based systems
install_on_debian() {
    echo "Installing utilities on Debian-based system..."
    sudo apt-get update
    sudo apt-get install -y ffmpegthumbnailer unar jq poppler-utils fd-find ripgrep btop
    # Create a symlink for fd if it's not already present
    if ! command -v fd &> /dev/null; then
        sudo ln -s $(which fdfind) /usr/local/bin/fd
    fi
    echo "Utilities installed successfully on Debian."
}

# Function to install utilities on macOS
install_on_macos() {
    echo "Installing utilities on macOS..."
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed."
    fi
    brew install ffmpegthumbnailer unar jq poppler fd ripgrep btop
    echo "Utilities installed successfully on macOS."
}

# Detect OS and execute appropriate installation function
OS="$(uname -s)"
case "$OS" in
    Linux)
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                install_on_debian
            else
                echo "This script supports Debian-based systems. Unsupported distribution."
                exit 1
            fi
        else
            echo "Cannot determine the Linux distribution."
            exit 1
        fi
        ;;
    Darwin)
        install_on_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

