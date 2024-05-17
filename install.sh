#!/bin/bash

# Define the directory containing the scripts
scripts_dir="./scripts"

# Check if the scripts directory exists
if [ ! -d "$scripts_dir" ]; then
    echo "The specified directory '$scripts_dir' does not exist."
    exit 1
fi

# Loop through all the .sh files in the scripts directory
for script in "$scripts_dir"/*.sh; do
    # Check if there are any files matching the pattern
    if [ -e "$script" ]; then
        echo "Processing script: $script"

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

