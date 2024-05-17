#My dotfiles

#Install

##Debian

sudo apt-get install stow

##MacOS

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

brew install stow

##


First, check out the dotfiles repo in your $HOME directory using git

$ git clone git@github.com/jebuschrast/dotfiles.git
$ cd dotfiles
then use GNU stow to create symlinks

$ stow .


