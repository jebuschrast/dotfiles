#!/bin/bash

# Function to install Zsh
install_zsh() {
    echo "Installing Zsh..."
    sudo $1 install zsh -y
    echo "Zsh installed successfully."
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    echo "Installing P10k them"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Oh My Zsh installed successfully."
}

# Function to install zoxide
install_zoxide() {
    echo "Installing zoxide..."
    sudo $1 install zoxide -y
    echo "zoxide installed successfully."
}


# Detect OS and install packages accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/debian_version ]]; then
            # Debian, Ubuntu, and derivatives
            if ! command -v zsh &> /dev/null; then
                install_oh_my_zsh
                curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
                install_zsh apt-get

                sudo apt-get install curl -y # Ensure curl is installed for Debian-based systems
            else
                echo "Zsh is already installed. Checking for Oh My Zsh and zoxide..."
                [ ! -d "$HOME/.oh-my-zsh" ] && install_oh_my_zsh
                command -v zoxide &> /dev/null || install_zoxide apt-get
            fi
        else
            echo "Unsupported Linux distribution. This script supports Debian-based systems."
            exit 1
        fi
        ;;
    Darwin) # macOS
        if ! command -v zsh &> /dev/null; then
            brew install zoxide
            install_oh_my_zsh
            brew install zsh
            install_oh_my_zsh
        else
            echo "Zsh is already installed. Checking for Oh My Zsh and zoxide..."
            [ ! -d "$HOME/.oh-my-zsh" ] && install_oh_my_zsh
            command -v zoxide &> /dev/null || brew install zoxide
        fi
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

