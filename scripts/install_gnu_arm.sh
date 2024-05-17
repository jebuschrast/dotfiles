#!/bin/bash

# Function to install the GNU Arm Embedded Toolchain on Debian-based systems
install_arm_toolchain_debian() {
    echo "Installing the GNU Arm Embedded Toolchain on Debian-based system..."
    # Install software-properties-common to manage repositories
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    # Add the PPA for the GNU Arm Embedded Toolchain
    sudo add-apt-repository ppa:team-gcc-arm-embedded/ppa
    sudo apt-get update
    sudo apt-get install -y gcc-arm-embedded
    echo "GNU Arm Embedded Toolchain installed successfully on Debian."
}

# Function to install the GNU Arm Embedded Toolchain on macOS
install_arm_toolchain_macos() {
    echo "Installing the GNU Arm Embedded Toolchain on macOS..."
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed."
    fi
    brew tap ArmMbed/homebrew-formulae
    brew install arm-none-eabi-gcc
    echo "GNU Arm Embedded Toolchain installed successfully on macOS."
}

# Detect OS and execute appropriate installation function
OS="$(uname -s)"
case "$OS" in
    Linux)
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                install_arm_toolchain_debian
            else
                echo "This script currently supports Debian-based systems only."
                exit 1
            fi
        else
            echo "Cannot determine the Linux distribution."
            exit 1
        fi
        ;;
    Darwin)
        install_arm_toolchain_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

