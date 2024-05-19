#!/bin/bash

#Install MacOS specific programs

echo "Installing iTerm2..."
brew install --cask iterm2
echo "iTerm2 installed successfully."

echo "Installing xCode tools..."
xcode-select --install
echo "xCode tools installed successfully."

echo "Installing VSCode..."
brew install --cask visual-studio-code
echo "VSCode installed successfully."
 
