#!/bin/bash

# Define the base directory containing the scripts
scripts_base_dir="./scripts"
OS=$(uname -s)
echo "Instaling OS specific prerequisites"
case "$OS" in
    Linux*)     echo "Linux"
        sudo apt-get update
        sudo apt get install openssh-server
        sudo apt-get install stow
        sudo apt-get install git
        ;;
    Darwin*)    echo "Mac"
        if ! command -v brew &> /dev/null; then
            echo "Homebrew is not installed. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Homebrew installed."
        fi
        brew install stow
        brew install git
esac

echo "If you are installing on an existing machine many of the config files need to be deleted in order to be reassociated with the ones being provided"
echo "Would you like to delete the existing config files? (y/n)"
read delete_choice
if [ "$delete_choice" == "y" ]; then
    echo "Deleting existing config files..."
    sudo rm -rf ~/.zshrc
    sudo rm -rf ~/.tmux.conf
    sudo rm -rf ~/.config/nvim
    sudo rm -rf ~/.config/yazi
    echo "Existing config files deleted."
fi

        
# Check if the scripts base directory exists
if [ ! -d "$scripts_base_dir" ]; then
    echo "The base directory '$scripts_base_dir' does not exist."
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
    echo "Would you like to execute all scripts automatically without individual confirmation? (y/n)"
    read auto_exec

    # Loop through all the .sh files in the specified scripts directory
    for script in "$scripts_dir"/*.sh; do
        # Check if there are any files matching the pattern
        if [ -e "$script" ]; then
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

            # Execute the script
            "$script" || echo "Failed to execute $script"
        else
            echo "No scripts found to execute."
            break
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

