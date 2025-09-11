#!/bin/bash

set -e  # Exit on error

# Define ZSH_CUSTOM if not already defined
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Function to clone Zsh plugins
clone_zsh_plugins() {
    echo "Cloning Zsh plugins..."

    # Ensure the custom plugins directory exists
    mkdir -p "$ZSH_CUSTOM/plugins"

    # Clone zsh-autosuggestions
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || {
            echo "Failed to clone zsh-autosuggestions"
            return 1
        }
    else
        echo "zsh-autosuggestions is already installed."
    fi

    # Clone zsh-syntax-highlighting
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || {
            echo "Failed to clone zsh-syntax-highlighting"
            return 1
        }
        echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
    else
        echo "zsh-syntax-highlighting is already installed."
    fi
    
    # Create themes directory if it doesn't exist
    mkdir -p "$ZSH_CUSTOM/themes"
    
    # Clone powerlevel10k
    if  [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
        echo "Installing powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" || {
            echo "Failed to clone powerlevel10k"
            return 1
        }
    else
        echo "powerlevel10k is already installed."
    fi

    # Clone you-should-use
    if [ ! -d "$ZSH_CUSTOM/plugins/you-should-use" ]; then
        echo "Installing you-should-use..."
        git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/plugins/you-should-use" || {
            echo "Failed to clone you-should-use"
            return 1
        }
    else
        echo "you-should-use is already installed."
    fi

    # Clone zsh-bat
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-bat" ]; then
        echo "Installing zsh-bat..."
        git clone https://github.com/fdellwing/zsh-bat.git "$ZSH_CUSTOM/plugins/zsh-bat" || {
            echo "Failed to clone zsh-bat"
            return 1
        }
    else 
        echo "zsh-bat is already installed."
    fi
    
    echo "Zsh plugins cloned successfully."
    
}

# check if zsh is installed
if [ -z "$(command -v zsh)" ]; then
    echo "Zsh is not installed. Please install Zsh first."
    exit 1
fi
# Check if Oh My Zsh is installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    clone_zsh_plugins
else
    echo "Oh My Zsh is not installed. Please install Oh My Zsh first."
    exit 1
fi

echo "Zsh plugin installation complete."

