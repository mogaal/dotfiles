# Dotfiles

## How to use it prerequisites

### Linux

Everything is installed from `~/dotfiles/install.sh` script using `-i` option 

### OSX

For personal laptop:

```
    % /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    % brew install jq python htop tree mr wget reattach-to-user-namespace tmux hh gpg git-crypt bat zsh direnv git-lfs node
    % brew cask install iterm2 docker google-chrome
    % chsh -s /bin/zsh 
```

We also need to install/download (not in brew): CopyClip, Keybase, Notion, Authy, Visual Studio Code (yes, hehehe)
 
For work laptop:

```
    % brew install terraform packer kops kubernetes-helm kubectl vault mr
```

## How to use it

Ensure you have at least `sudo` and `git` installed and then clone the repository inside your home directory 

```console
    % git clone --recursive https://github.com/mogaal/dotfiles.git
    % git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

Finally we execute the installer script

```console
    % bash ~/dotfiles/install.sh -i # To install the apps
    % bash ~/dotfiles/install.sh -d # To install the dotfiles
```
