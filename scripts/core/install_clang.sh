#!/bin/bash

# Function to install Clang on Debian-based systems
install_on_debian() {
    echo "Installing Clang on Debian-based system..."
    sudo apt-get update
    sudo apt-get install -y clang lldb llvm
    echo "Clang, LLDB, and LLVM installed successfully on Debian."
}

# Function to install Clang on macOS
install_on_macos() {
    echo "Installing Clang on macOS..."
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed."
    fi
    brew install llvm
    echo "Clang, LLDB, and LLVM installed successfully on macOS."
    echo "Please note: If you want Clang to be the default compiler, adjust your PATH as follows:"
    echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"'
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

