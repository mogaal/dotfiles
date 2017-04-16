# Dotfiles

## How to use it prerequisites

The must 

    % apt install less mc tmux vim htop links2 wget git tmux powerline tree zsh curl dnsutils
  
Extras:

    % apt install cryptsetup vlc irssi texlive-latex-base libreoffice


## How to use it

First you need to clone the repository inside your home directory 

    % git clone --recursive https://github.com/mogaal/dotfiles.git
    % git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

Then we need to execute the installer script

    % bash ~/dotfiles/install.sh

