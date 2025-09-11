#!/bin/bash

set -e  # Exit on error

# Function to install Zsh
install_zsh() {
    echo "Installing Zsh..."
    sudo $1 install zsh -y || {
        echo "Failed to install Zsh"
        return 1
    }
    echo "Zsh installed successfully."
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
        echo "Failed to install Oh My Zsh"
        return 1
    }
    echo "Oh My Zsh installed successfully."
    
    # Install p10k theme after Oh My Zsh
    echo "Installing powerlevel10k theme"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || {
        echo "Failed to install powerlevel10k theme"
        return 1
    }
    echo "powerlevel10k theme installed successfully."
    
    # Install additional ZSH plugins
    echo "Installing ZSH plugins..."
    
    # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || {
        echo "Failed to install zsh-autosuggestions plugin"
        return 1
    }
    
    # zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || {
        echo "Failed to install zsh-syntax-highlighting plugin"
        return 1
    }
    
    # you-should-use
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use || {
        echo "Failed to install you-should-use plugin"
        return 1
    }
    
    # zsh-bat
    git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat || {
        echo "Failed to install zsh-bat plugin"
        return 1
    }
    
    # zsh-ai
    git clone https://github.com/zthxxx/zsh-history-enquirer.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-ai || {
        echo "Warning: Failed to install zsh-ai plugin - this may not be available in repositories"
    }
    
    echo "ZSH plugins installed successfully."
}

# Function to install zoxide
install_zoxide() {
    echo "Installing zoxide..."
    sudo $1 install zoxide -y || {
        echo "Failed to install zoxide"
        return 1
    }
    echo "zoxide installed successfully."
}


# Detect OS and install packages accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/debian_version ]]; then
            # Debian, Ubuntu, and derivatives
            # First install curl for other dependencies
            if ! command -v curl &> /dev/null; then
                sudo apt-get install curl -y || {
                    echo "Failed to install curl"
                    exit 1
                }
            fi
            
            # Install Zsh if needed
            if ! command -v zsh &> /dev/null; then
                install_zsh apt-get
            else
                echo "Zsh is already installed."
            fi
            
            # Install Oh My Zsh if needed
            if [ ! -d "$HOME/.oh-my-zsh" ]; then
                install_oh_my_zsh
            else
                echo "Oh My Zsh is already installed."
            fi
            
            # Install zoxide if needed
            if ! command -v zoxide &> /dev/null; then
                curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh || install_zoxide apt-get
            else
                echo "zoxide is already installed."
            fi
        else
            echo "Unsupported Linux distribution. This script supports Debian-based systems."
            exit 1
        fi
        ;;
    Darwin) # macOS
        # Install Zsh if needed
        if ! command -v zsh &> /dev/null; then
            brew install zsh || {
                echo "Failed to install Zsh"
                exit 1
            }
            echo "Zsh installed successfully."
        else
            echo "Zsh is already installed."
        fi
        
        # Install Oh My Zsh if needed
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            install_oh_my_zsh
        else
            echo "Oh My Zsh is already installed."
        fi
        
        # Install zoxide if needed
        if ! command -v zoxide &> /dev/null; then
            brew install zoxide || {
                echo "Failed to install zoxide"
                exit 1
            }
            echo "zoxide installed successfully."
        else
            echo "zoxide is already installed."
        fi
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

