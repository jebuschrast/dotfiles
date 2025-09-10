#!/bin/bash

set -e  # Exit on error

# Define the base directory containing the scripts
scripts_base_dir="./scripts"
OS=$(uname -s)
echo "Installing OS specific prerequisites"
case "$OS" in
    Linux*)     echo "Linux"
        sudo apt-get update || { echo "Failed to update package lists"; exit 1; }
        sudo apt-get install -y stow git openssh-server || { echo "Failed to install dependencies"; exit 1; }
        ;;
    Darwin*)    echo "Mac"
        if ! command -v brew &> /dev/null; then
            echo "Homebrew is not installed. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Homebrew installed."
        fi
        brew install stow git || { echo "Failed to install dependencies with Homebrew"; exit 1; }
esac



        
# Check if the scripts base directory exists
if [ ! -d "$scripts_base_dir" ]; then
    echo "The base directory '$scripts_base_dir' does not exist."
    exit 1
fi

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: 'stow' is required but not installed."
    exit 1
fi

echo "This script will process individual scripts located in the '$scripts_base_dir' directory."
echo "These scripts are organized into 'core' and 'optional' categories and are designed to install a variety of tools and utilities on your system."
echo "You can choose to install scripts from 'core', 'optional', or both categories."
echo "Would you like to install scripts from 'core', 'optional', or 'both'? Please type 'core', 'optional', or 'both':"
read category_choice

# Validate category choice
if [ "$category_choice" != "core" ] && [ "$category_choice" != "optional" ] && [ "$category_choice" != "both" ]; then
    echo "Invalid category choice. Exiting."
    exit 1
fi

# Function to process scripts in a directory
process_scripts() {
    local scripts_dir=$1
    echo "Processing scripts in the '$scripts_dir' directory..."
    
    # Check if there are any scripts in the directory
    shopt -s nullglob
    scripts=("$scripts_dir"/*.sh)
    if [ ${#scripts[@]} -eq 0 ]; then
        echo "No scripts found in '$scripts_dir'."
        return 0
    fi
    
    echo "Would you like to execute all scripts automatically without individual confirmation? (y/n)"
    read auto_exec

    # Loop through all the .sh files in the specified scripts directory
    for script in "${scripts[@]}"; do
        echo "Processing script: $script"

        # User decides for each script if the mode is not automatic
        if [ "$auto_exec" != "y" ]; then
            echo "Do you want to execute this script? (y/n)"
            read exec_choice
            if [ "$exec_choice" != "y" ]; then
                echo "Skipping: $script"
                continue
            fi
        fi

        # Make sure the script is executable
        chmod +x "$script"

        # Execute the script and capture return code
        echo "Running: $script"
        "$script"
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            echo "Warning: Script $script exited with code $exit_code"
        else
            echo "Successfully executed: $script"
        fi
    done
}

# Decide which directories to process based on user input
if [ "$category_choice" == "core" ] || [ "$category_choice" == "both" ]; then
    process_scripts "$scripts_base_dir/core"
fi
if [ "$category_choice" == "optional" ] || [ "$category_choice" == "both" ]; then
    process_scripts "$scripts_base_dir/optional"
fi

echo "All selected scripts have been processed."

echo "If you are installing on an existing machine many of the config files need to be deleted in order to be reassociated with the ones being provided"
echo "Would you like to backup and delete the existing config files? (y/n)"
read delete_choice
if [ "$delete_choice" == "y" ]; then
    # Create backup directory with timestamp
    backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    echo "Creating backup in $backup_dir"
    
    # Backup function
    backup_file() {
        if [ -e "$1" ]; then
            echo "Backing up $1"
            cp -r "$1" "$backup_dir/" 2>/dev/null || echo "Failed to backup $1"
        fi
    }
    
    # Backup files before deletion
    backup_file ~/.zshrc
    backup_file ~/.tmux.conf
    backup_file ~/.p10k.zsh
    backup_file ~/.config/nvim
    backup_file ~/.config/yazi
    backup_file ~/.local/share/nvim
    backup_file ~/.local/state/nvim
    backup_file ~/.cache/nvim
    backup_file ~/.cache/nvim.bak
    
    echo "Deleting existing config files..."
    rm -f ~/.zshrc
    rm -f ~/.tmux.conf
    rm -f ~/.p10k.zsh
    rm -rf ~/.config/nvim
    rm -rf ~/.config/yazi
    echo "Existing config files deleted."

    echo "Deleting nvim directories..."
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim ~/.cache/nvim.bak
fi

echo "Using GNU stow to symlink the config files"
stow . -vv || { echo "Failed to create symlinks using stow"; exit 1; }

# Set zsh as the default shell if it's installed
if command -v zsh &> /dev/null; then
    echo "Setting zsh as the default shell..."
    ZSH_PATH=$(which zsh)
    
    # Check if zsh is already the default shell
    if [ "$SHELL" != "$ZSH_PATH" ]; then
        # Make sure zsh is in /etc/shells
        if ! grep -q "^$ZSH_PATH$" /etc/shells; then
            echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
        fi
        
        # Change the default shell
        chsh -s "$ZSH_PATH" || {
            echo "Failed to set zsh as default shell. You can do this manually with:"
            echo "chsh -s $ZSH_PATH"
        }
        
        echo "zsh is now your default shell!"
    else
        echo "zsh is already your default shell."
    fi
else
    echo "zsh is not installed. Default shell unchanged."
fi

echo "Installation complete! Please restart your terminal for all changes to take effect."
