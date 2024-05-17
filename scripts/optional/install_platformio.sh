#!/bin/bash

# Function to install Python and pip
install_python_pip() {
    echo "Checking for Python and pip..."
    if ! command -v python3 &> /dev/null; then
        echo "Python 3 is not installed. Installing Python..."
        sudo apt-get install -y python3
    fi

    if ! command -v pip3 &> /dev/null; then
        echo "pip for Python 3 is not installed. Installing pip..."
        sudo apt-get install -y python3-pip
    fi
}

# Function to install PlatformIO
install_platformio() {
    echo "Installing PlatformIO via pip..."
    pip3 install -U platformio
    echo "PlatformIO installed successfully."
}

# Main execution function
main() {
    echo "Starting installation of PlatformIO..."

    # Detect OS and install prerequisites
    OS="$(uname -s)"
    case "$OS" in
        Linux|Darwin)
            install_python_pip
            install_platformio
            ;;
        *)
            echo "Unsupported operating system."
            exit 1
            ;;
    esac

    echo "PlatformIO installation complete."
}

# Call the main function to start the installation
main

