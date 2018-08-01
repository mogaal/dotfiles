# Dotfiles

## How to use it prerequisites

### Linux

The must 

    % apt install less mc tmux vim htop wget git tmux tree zsh curl dnsutils
  
Extras:

    % apt install cryptsetup vlc irssi texlive-latex-base libreoffice compton rofi

### OSX

For personal laptop:

```
    % brew install jq python htop tree mr wget reattach-to-user-namespace tmux iterm2
```

For work laptop:

```
    % brew install terraform packer kops kubernetes-helm kubectl vault
```

## How to use it

First you need to clone the repository inside your home directory 

    % git clone --recursive https://github.com/mogaal/dotfiles.git
    % git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

Then we need to execute the installer script

    % bash ~/dotfiles/install.sh

