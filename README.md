# Dotfiles

## How to use it prerequisites

### Linux

The must 

```
    % apt install less mc vim htop wget git tmux tree zsh curl dnsutils git-crypt
```

Extras:

```
    % apt install cryptsetup vlc irssi texlive-latex-base libreoffice compton rofi 
```

For work:

```
    % apt install myrepos 
```

### OSX

For personal laptop:

```
    % brew install jq python htop tree mr wget reattach-to-user-namespace tmux hh gpg git-crypt bat 
    % brew cask install iterm2 docker
```

For work laptop:

```
    % brew install terraform packer kops kubernetes-helm kubectl vault mr
```

## How to use it

First you need to clone the repository inside your home directory 

```console
    % git clone --recursive https://github.com/mogaal/dotfiles.git
    % git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

Finally we execute the installer script

```console
    % bash ~/dotfiles/install.sh
```
