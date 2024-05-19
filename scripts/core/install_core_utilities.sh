#!/bin/bash

# Function to install tmux, lsd, and mosh on Debian-based systems
install_packages_debian() {
    echo "Installing tmux, lsd, and mosh on Debian-based system..."
    sudo apt-get update
    sudo apt-get install -y tmux lsd mosh zoxide
    echo "tmux, lsd, and mosh installed successfully on Debian."
}

# Function to install tmux, lsd, and mosh on macOS
install_packages_macos() {
    echo "Installing tmux, lsd, and mosh on macOS..."
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed."
    fi
    brew install tmux lsd mosh zoxide
    echo "tmux, lsd, and mosh installed successfully on macOS."
}

# Detect OS and execute appropriate installation function
OS="$(uname -s)"
case "$OS" in
    Linux)
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                install_packages_debian
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
        install_packages_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

