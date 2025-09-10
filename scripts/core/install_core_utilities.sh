#!/bin/bash

set -e  # Exit on error

# Function to install tmux, lsd, and mosh on Debian-based systems
install_packages_debian() {
    echo "Installing tmux, lsd, and mosh on Debian-based system..."
    sudo apt-get update || {
        echo "Failed to update package lists"
        return 1
    }
    
    # Check if lsd is available in repositories
    if apt-cache show lsd &>/dev/null; then
        sudo apt-get install -y tmux lsd mosh zoxide || {
            echo "Failed to install packages"
            return 1
        }
    else
        echo "lsd not found in apt repositories. Installing tmux, mosh, and zoxide instead."
        sudo apt-get install -y tmux mosh zoxide || {
            echo "Failed to install packages"
            return 1
        }
        
        echo "Installing lsd from cargo..."
        if command -v cargo &>/dev/null; then
            cargo install lsd || {
                echo "Failed to install lsd via cargo. Install cargo and try again."
            }
        else
            echo "cargo not found. Installing rust to get cargo..."
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || {
                echo "Failed to install rust"
            }
            source "$HOME/.cargo/env"
            cargo install lsd || echo "Failed to install lsd via cargo"
        fi
    fi
    
    echo "tmux, zoxide, and mosh installed successfully on Debian."
    
    echo "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') || {
        echo "Failed to get latest lazygit version"
        return 1
    }
    
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" || {
        echo "Failed to download lazygit"
        return 1
    }
    
    tar xf lazygit.tar.gz lazygit || {
        echo "Failed to extract lazygit"
        rm -f lazygit.tar.gz
        return 1
    }
    
    sudo install lazygit /usr/local/bin || {
        echo "Failed to install lazygit to /usr/local/bin"
        rm -f lazygit.tar.gz lazygit
        return 1
    }
    
    # Cleanup
    rm -f lazygit.tar.gz lazygit
    
    # Verify installation
    if command -v lazygit &>/dev/null; then
        echo "lazygit installed successfully."
    else
        echo "lazygit installation failed."
        return 1
    fi
}

# Function to install tmux, lsd, and mosh on macOS
install_packages_macos() {
    echo "Installing tmux, lsd, and mosh on macOS..."
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            echo "Failed to install Homebrew"
            return 1
        }
        echo "Homebrew installed."
        
        # Add Homebrew to PATH for the current session
        eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)" || {
            echo "Failed to add Homebrew to PATH"
            return 1
        }
    fi
    
    # Install packages individually to better handle failures
    for package in tmux lsd mosh zoxide lazygit; do
        echo "Installing $package..."
        if ! brew list $package &>/dev/null; then
            brew install $package || {
                echo "Failed to install $package"
                continue
            }
            echo "$package installed successfully."
        else
            echo "$package is already installed."
        fi
    done
    
    # Verify all packages were installed
    all_installed=true
    for package in tmux lsd mosh zoxide lazygit; do
        if ! command -v $package &>/dev/null; then
            echo "Warning: $package doesn't seem to be installed or not in PATH."
            all_installed=false
        fi
    done
    
    if $all_installed; then
        echo "All packages installed successfully on macOS."
    else
        echo "Some packages might not have been installed correctly."
    fi
}

# Detect OS and execute appropriate installation function
OS="$(uname -s)"
case "$OS" in
    Linux)
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ] || [ "$ID" = "ubuntu" ]; then
                install_packages_debian || {
                    echo "Failed to install packages on Debian-based system"
                    exit 1
                }
            else
                echo "This script supports Debian-based systems. Detected distribution: $ID"
                exit 1
            fi
        else
            echo "Cannot determine the Linux distribution."
            exit 1
        fi
        ;;
    Darwin)
        install_packages_macos || {
            echo "Failed to install packages on macOS"
            exit 1
        }
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

