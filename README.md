# My Dotfiles

This repository contains my personal dotfiles. Dotfiles are configuration files that are used to customize and tweak your system and software. The configurations in this repository are managed using GNU Stow, a symlink farm manager, which facilitates the management of symbolic links to dotfiles across the system.

## Installation

Before setting up the dotfiles, you must install GNU Stow, which will be used to create symlinks to the configuration files in this repository.

### Debian

On Debian or any Debian-based distribution like Ubuntu, install GNU Stow using the package manager:

```bash
sudo apt-get install stow
```
### MacOS

On macOS, you'll first need to install Homebrew if it isn't already installed, followed by GNU Stow lang-none -->

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install stow
```
## Setting up Dotfiles

To set up the dotfiles, clone this repository to your $HOME directory and use GNU Stow to create the necessary symlinks:

```bash
git clone git@github.com:jebuschrast/dotfiles.git

cd dotfiles

stow .
```

This command will link the files and folders in the dotfiles repository to your home directory, effectively applying all the specified configurations.
