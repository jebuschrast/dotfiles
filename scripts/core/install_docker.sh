#!/bin/bash

# Function to install Docker on Debian
install_docker_debian() {
    echo "Installing Docker on Debian-based system..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker installed successfully on Debian."
}

# Function to install Docker on macOS
install_docker_macos() {
    echo "Installing Docker on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew first..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Homebrew installed."
    fi
    brew install --cask docker
    open /Applications/Docker.app
    echo "Docker installed successfully on macOS."
}

# Detect OS and install Docker accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                install_docker_debian
            else
                echo "Unsupported Linux distribution. This script only supports Debian-based systems."
                exit 1
            fi
        else
            echo "Cannot determine the Linux distribution."
            exit 1
        fi
        ;;
    Darwin) # macOS
        install_docker_macos
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

