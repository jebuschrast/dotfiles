# My Dotfiles

This repository contains my personal dotfiles. Dotfiles are configuration files that are used to customize and tweak your system and software.

With this repo you will be able to bring up a new system with your personal configurations instantly. 
The scripts automatically detect if the host machine is running Debian Linux or MacOS.

The configurations in this repository are managed using GNU Stow, a symlink farm manager, which facilitates the management of symbolic links to dotfiles across the system.


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
### NERD Fonts
For optimal compatibility with themes and tools that utilize a wide range of glyphs (icons and special characters), it is recommended to install [**NERD Fonts**](https://www.nerdfonts.com/). NERD Fonts patches developer-targeted fonts with a high number of glyphs (icons). This ensures that icons and graphics in your terminal render correctly and enhance visual information.

- To install NERD Fonts, visit their website: [NERD Fonts](https://www.nerdfonts.com/font-downloads) and select a font that fits your aesthetic and functional needs. Download and install it according to your operating system's procedure for adding new fonts.


## Setting up Dotfiles

To set up the dotfiles, clone this repository to your $HOME directory and use GNU Stow to create the necessary symlinks:

```bash
cd ~

git clone git@github.com:jebuschrast/dotfiles.git

cd dotfiles

stow .
```

This command will link the files and folders in the dotfiles repository to your home directory, effectively applying all the specified configurations

## Setting up the system

Now all you need to do is change the permissions on the install script and run it.

```bash
chmod +x install.sh

./install.sh

```

The script will give you the option to install one script at a time if you want to be selective or just install everything all at once.

### List of installed software.

#### Core Software
- [**clang**](https://clang.llvm.org/) - A language front-end for the LLVM compiler.
- [**docker**](https://www.docker.com/) - Container platform for developing, shipping, and running applications.
- [**gh**](https://cli.github.com/) - GitHub CLI to manage GitHub repositories.
- [**mosh**](https://mosh.org/) - Mobile shell that supports roaming and intermittent connectivity.
- [**nvim**](https://neovim.io/) - Hyperextensible Vim-based text editor.
- [**tmux**](https://github.com/tmux/tmux) - Terminal multiplexer for Unix-like operating systems.
- **zsh**
  - [**zsh**](https://www.zsh.org/) - A powerful shell that operates as both an interactive shell and as a scripting language interpreter.i
  - [**Oh My Zsh**](https://ohmyz.sh/) - An open-source, community-driven framework for managing your Zsh configuration with tons of plugins and themes.
  - [**Zoxide**](https://github.com/ajeetdsouza/zoxide) - A fast alternative to `cd` that learns your habits, making it quicker to navigate directories.
  - [**Powerlevel10k**](https://github.com/romkatv/powerlevel10k) - A fast and highly customizable theme for the Zsh shell. It provides prompt elements that help display various status indicators and system information quickly and beautifully. Powerlevel10k is designed to be fast, flexible, and easy to use, offering configurations that can transform the command prompt into a versatile tool for any workflow.
- **zsh plugins**
  - [**zsh-autosuggestions**](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like fast/unobtrusive autosuggestions for Zsh.
  - [**zsh-syntax-highlighting**](https://github.com/zsh-users/zsh-syntax-highlighting) - Provides syntax highlighting for the shell Zsh.

#### Optional Software
- [**gnu_arm**](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm) - GNU Toolchain for the ARM processor architecture.
- [**gnu_radio**](https://www.gnuradio.org/) - Free & open-source toolkit for software radio.
- [**nvm**](https://github.com/nvm-sh/nvm) - Node Version Manager - POSIX-compliant bash script to manage multiple active node.js versions.
- [**openocd**](http://openocd.org/) - Open On-Chip Debugger for embedded debugging.
- [**platformio**](https://platformio.org/) - A professional collaborative platform for embedded development.
- [**rust**](https://www.rust-lang.org/) - A language empowering everyone to build reliable and efficient software.
- [**yazi**](https://crates.io/crates/yazi) - Tool from crates.io (Note: Link to the specific crate if yazi refers to a specific project).
- **utilities**
  - [**ffmpegthumbnailer**](https://github.com/dirkvdb/ffmpegthumbnailer) - Lightweight video thumbnailer that can be used by file managers.
  - [**unar**](https://theunarchiver.com/command-line) - Command line unarchiving tools for various archive formats.
  - [**jq**](https://stedolan.github.io/jq/) - Lightweight and flexible command-line JSON processor.
  - [**poppler-utils**](https://poppler.freedesktop.org/) - PDF rendering library based on xpdf-3.0.
  - [**fd-find**](https://github.com/sharkdp/fd) - A simple, fast and user-friendly alternative to 'find'.
  - [**ripgrep**](https://github.com/BurntSushi/ripgrep) - A line-oriented search tool that recursively searches your current directory for a regex pattern.
  - [**btop**](https://github.com/aristocratos/btop) - A resource monitor that shows usage and stats for processor, memory, disks, network, and processes.


