#!/bin/bash

# Function to clone Zsh plugins
clone_zsh_plugins() {
    echo "Cloning Zsh plugins..."

    # Ensure the custom plugins directory exists
    mkdir -p ~/.oh-my-zsh/custom/plugins

    # Clone zsh-autosuggestions
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    else
        echo "zsh-autosuggestions is already installed."
    fi

    # Clone zsh-syntax-highlighting
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    else
        echo "zsh-syntax-highlighting is already installed."
    fi
}

# Check if Oh My Zsh is installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    clone_zsh_plugins
else
    echo "Oh My Zsh is not installed. Please install Oh My Zsh first."
    exit 1
fi

echo "Zsh plugin installation complete."

