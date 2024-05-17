#!/bin/bash

# This script installs Rust and Yazı (a tool from crates.io)

echo "Installing Rust..."

# Install Rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Source the Rust environment to use Rust tools immediately
source $HOME/.cargo/env

# Update Rust to the latest version
rustup update

echo "Rust installed and updated. Installing Yazı..."

# Install Yazi from crates.io
cargo install --locked yazi-fm yazi-cli

echo "Yazı installation complete."

