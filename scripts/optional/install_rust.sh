#!/bin/bash

# This script installs Rust programming language

echo "Installing Rust..."

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl could not be found. Please install curl first."
    exit 1
fi

# Install Rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# The script will automatically configure the current shell
# Source the cargo env (you might want to add this to your shell profile)
source $HOME/.cargo/env

# Update Rust to ensure the latest version is installed
rustup update

echo "Rust installation and update complete."

