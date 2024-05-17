#!/bin/bash

# Define the directory containing the scripts
scripts_dir="./scripts"

# Check if the scripts directory exists
if [ ! -d "$scripts_dir" ]; then
    echo "The specified directory '$scripts_dir' does not exist."
    exit 1
fi

# Provide a description and ask the user for the mode of execution
echo "This script will process a series of individual scripts located in '$scripts_dir'."
echo "These scripts are designed to install a variety of tools and utilities on your system."
echo "You can choose to automatically execute all scripts, to manually confirm each script execution, or exit at any time with ctrl + C."
echo "Would you like to execute all scripts automatically without individual confirmation? (y/n)"
read auto_exec

# Loop through all the .sh files in the scripts directory
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

echo "All scripts processed."

