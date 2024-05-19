#!/bin/bash

# Function to install GitHub CLI on Debian
install_gh_cli_debian() {
    echo "Installing GitHub CLI on Debian-based system..."
    sudo apt update
    sudo apt install -y software-properties-common apt-transport-https gnupg
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
    echo "GitHub CLI installed successfully on Debian."
}

# Function to install GitHub CLI on macOS
install_gh_cli_macos() {
    echo "Installing GitHub CLI on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Please install Homebrew first."
        exit 1
    fi
    brew install gh
    echo "GitHub CLI installed successfully on macOS."
}

# Detect OS and install GitHub CLI accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                install_gh_cli_debian
            else
                echo "Unsupported Linux distribution. This script only supports Debian-based systems."
                exit 1
            fi
        else
            echo "Cannot determine the Linux distribution."
            exit 1
        fi
        ;;
    Darwin) # macOS
        install_gh_cli_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

