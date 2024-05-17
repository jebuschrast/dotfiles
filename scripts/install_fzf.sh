#!/bin/bash

# Function to install fzf from GitHub
install_fzf() {
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    echo "fzf installed successfully."
}

# Function to check for and install Git
check_and_install_git() {
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. Installing Git..."
        sudo $1 install git -y
    fi
}

# Detect OS and install fzf accordingly
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                check_and_install_git apt-get
                install_fzf
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
        if ! command -v brew &> /dev/null; then
            echo "Homebrew is not installed. Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Homebrew installed."
        fi
        check_and_install_git brew
        install_fzf
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

