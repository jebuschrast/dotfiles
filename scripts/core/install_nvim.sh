#!/bin/bash

# Function to install Neovim from repository
install_neovim_from_repo() {
    echo "Installing Neovim from repository..."
    sudo $1 install neovim -y
    rm -rm neovim
    echo "Neovim installed successfully."
}

# Function to build Neovim from source on Debian
build_neovim_from_source() {
    echo "Building Neovim from source..."
    sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ..
    rm -rf neovim
    echo "Neovim built and installed from source successfully."
}

# Detect OS and install packages accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/debian_version ]]; then
            # Debian, Ubuntu, and derivatives
            if ! command -v nvim &> /dev/null; then
                build_neovim_from_source
            else
                echo "Neovim is already installed."
            fi
        else
            echo "Unsupported Linux distribution. This script is configured to build Neovim from source only on Debian-based systems."
            exit 1
        fi
        ;;
    Darwin) # macOS
        if ! command -v nvim &> /dev/null; then
            if ! command -v brew &> /dev/null; then
                echo "Homebrew is not installed. Please install Homebrew first."
                exit 1
            fi
            brew install neovim
            echo "Neovim installed successfully."
        else
            echo "Neovim is already installed."
        fi
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

