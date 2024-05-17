#!/bin/bash

# Function to install OpenOCD on Debian-based systems
install_openocd_debian() {
    echo "Installing OpenOCD on Debian-based system..."
    sudo apt-get update
    sudo apt-get install -y openocd
    echo "OpenOCD installed successfully on Debian."
}

# Function to install OpenOCD on macOS
install_openocd_macos() {
    echo "Installing OpenOCD on macOS..."
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed."
    fi
    brew install openocd
    echo "OpenOCD installed successfully on macOS."
}

# Optional: Function to build OpenOCD from source
build_openocd_from_source() {
    echo "Building OpenOCD from source..."
    # Install dependencies
    sudo apt-get install -y git make libtool pkg-config autoconf automake texinfo libusb-1.0-0-dev libhidapi-dev
    # Clone the repository
    git clone --recursive https://github.com/ntfreak/openocd.git
    cd openocd
    # Bootstrap and configure
    ./bootstrap
    ./configure
    # Make and install
    make
    sudo make install
    echo "OpenOCD built and installed from source."
}

# Detect OS and execute appropriate function
OS="$(uname -s)"
case "$OS" in
    Linux)
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                install_openocd_debian
            else
                echo "Unsupported distribution for packaged OpenOCD, attempting to build from source."
                build_openocd_from_source
            fi
        else
            echo "Cannot determine the Linux distribution."
            exit 1
        fi
        ;;
    Darwin)
        install_openocd_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

