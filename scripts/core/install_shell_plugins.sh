#!/bin/bash

# Function to clone Zsh plugins
clone_zsh_plugins() {
    echo "Cloning Zsh plugins..."

    # Ensure the custom plugins directory exists
    mkdir -p ~/.oh-my-zsh/custom/plugins

    # Clone zsh-autosuggestions
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions  ${ZSH_CUSTOM)/plugins/zsh-autosuggestions
    else
        echo "zsh-autosuggestions is already installed."
    fi

    # Clone zsh-syntax-highlighting
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM)/plugins/zsh-syntax-highlighting
    else
        echo "zsh-syntax-highlighting is already installed."
    fi
    echo "Zsh plugins cloned successfully."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    
    # clone you-should-use
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/you-should-use" ]; then
        echo "Installing you-should-use..."
        git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM)/plugins/you-should-use
    else
        echo "you-should-use is already installed."
    fi

    # clone zsh-bat
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-bat" ]; then
        echo "Installing zsh-bat..."
        git clone https://github.com/fdellwing/zsh-bat.git ~/.oh-my-zsh/custom/plugins/zsh-bat
    else 
        echo "zsh-bat is already installed."
    fi
    
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

