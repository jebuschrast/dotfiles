#!/bin/bash

set -e  # Exit on error

# Function to install AstroNvim
install_astronvim() {
    echo "Installing AstroNvim..."
    
    # Make a backup of current nvim config (if exists)
    if [ -d "$HOME/.config/nvim" ]; then
        echo "Making backup of existing nvim config..."
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
    fi
    
    # Clean neovim folders (Optional but recommended)
    if [ -d "$HOME/.local/share/nvim" ]; then
        echo "Backing up nvim share directory..."
        mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.bak"
    fi
    
    if [ -d "$HOME/.local/state/nvim" ]; then
        echo "Backing up nvim state directory..."
        mv "$HOME/.local/state/nvim" "$HOME/.local/state/nvim.bak"
    fi
    
    if [ -d "$HOME/.cache/nvim" ]; then
        echo "Backing up nvim cache directory..."
        mv "$HOME/.cache/nvim" "$HOME/.cache/nvim.bak"
    fi
    
    # Clone the repository
    echo "Cloning AstroNvim template..."
    git clone --depth 1 https://github.com/AstroNvim/template "$HOME/.config/nvim" || {
        echo "Failed to clone AstroNvim template"
        return 1
    }
    
    # Remove template's git connection
    echo "Removing template's git connection..."
    rm -rf "$HOME/.config/nvim/.git"
    
    echo "AstroNvim installed successfully!"
    echo "Run 'nvim' to complete the setup."
    
    return 0
}

# Function to install Neovim from repository
install_neovim_from_repo() {
    echo "Installing Neovim from repository..."
    sudo $1 install neovim -y || {
        echo "Failed to install Neovim from repository"
        return 1
    }
    echo "Neovim installed successfully."
}

# Function to build Neovim from source on Debian
build_neovim_from_source() {
    echo "Building Neovim from source..."
    
    # Install build dependencies
    echo "Installing build dependencies..."
    sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen || {
        echo "Failed to install build dependencies"
        return 1
    }
    
    # Remove existing neovim source directory if it exists
    if [ -d "neovim" ]; then
        echo "Removing existing neovim source directory..."
        rm -rf neovim
    fi
    
    # Clone repository
    echo "Cloning Neovim repository..."
    git clone https://github.com/neovim/neovim.git || {
        echo "Failed to clone Neovim repository"
        return 1
    }
    
    # Build and install
    cd neovim || return 1
    git checkout stable || {
        echo "Failed to checkout stable branch"
        cd ..
        rm -rf neovim
        return 1
    }
    
    echo "Building Neovim..."
    make CMAKE_BUILD_TYPE=RelWithDebInfo || {
        echo "Failed to build Neovim"
        cd ..
        rm -rf neovim
        return 1
    }
    
    echo "Installing Neovim..."
    sudo make install || {
        echo "Failed to install Neovim"
        cd ..
        rm -rf neovim
        return 1
    }
    
    # Clean up
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
                build_neovim_from_source || {
                    echo "Failed to build and install Neovim from source"
                    exit 1
                }
            else
                echo "Neovim is already installed."
                
                # Ask if user wants to install AstroNvim
                echo "Do you want to install AstroNvim? (y/n)"
                read install_astro
                if [ "$install_astro" = "y" ]; then
                    install_astronvim
                fi
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
            brew install neovim || {
                echo "Failed to install Neovim with Homebrew"
                exit 1
            }
            echo "Neovim installed successfully."
            
            # Install AstroNvim
            echo "Do you want to install AstroNvim? (y/n)"
            read install_astro
            if [ "$install_astro" = "y" ]; then
                install_astronvim
            fi
        else
            echo "Neovim is already installed."
        fi
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

