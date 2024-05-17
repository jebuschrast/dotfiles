#!/bin/bash

# Function to install nvm, Node.js, and npm
install_nvm_node_npm() {
    echo "Installing nvm (Node Version Manager)..."
    # Fetch the latest version of the nvm install script and execute it
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep 'tag_name' | cut -d\" -f4)/install.sh | bash

    # Determine the shell type and configure source paths
    SHELL_TYPE=$(basename "$SHELL")
    export NVM_DIR="$HOME/.nvm"
    if [ "$SHELL_TYPE" = "zsh" ]; then
        # Load nvm script and set up completion for Zsh
        echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.zshrc  # This loads nvm
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> $HOME/.zshrc  # This loads nvm bash_completion
        echo "autoload -U +X bashcompinit && bashcompinit" >> $HOME/.zshrc
        echo "autoload -U +X compinit && compinit" >> $HOME/.zshrc
        source $HOME/.zshrc
    elif [ "$SHELL_TYPE" = "bash" ]; then
        # Load nvm script and set up completion for Bash
        echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.bashrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.bashrc  # This loads nvm
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> $HOME/.bashrc  # This loads nvm bash_completion
        source $HOME/.bashrc
    else
        echo "Unsupported shell type. nvm might not work as expected!"
    fi

    echo "Installing Node.js and npm using nvm..."
    nvm install node # "node" is an alias for the latest version
    nvm use node
    echo "Node.js and npm installed successfully using nvm."
}

# Detect OS and execute installation
OS="$(uname -s)"
case "$OS" in
    Linux) # Linux OS
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                install_nvm_node_npm
            else
                echo "Unsupported Linux distribution. This script is configured for Debian-based systems."
                exit 1
            fi
        else
            echo "Cannot determine the Linux distribution."
            exit 1
        fi
        ;;
    Darwin) # macOS
        install_nvm_node_npm
        ;;
    *)
        echo "Unsupported operating system."
        exit 1
        ;;
esac

