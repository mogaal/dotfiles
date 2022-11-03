#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

####################
# Basic functions #
####################

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-i] [-d]

Minimal bash script to manage dotfiles.

Available options:

-i, --install-apps         Install the must apps"
-d, --dotfiles             Install the dotfiles "
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

##############
#### VARS ####
##############

DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BACKUP="$(dirname "$DOTFILES")/dotfiles_old"

##################
#### FUNCTIONS ###
##################

function install {
  if [[ "$OSTYPE" == darwin* ]]; then
    brew install \
      jq \
      python \
      htop \
      tree \
      mr \
      redshift \ # This is because i3 and night light
      wget \
      reattach-to-user-namespace \
      tmux \ 
      hh \
      gpg \
      git-crypt \
      bat \
      zsh \
      direnv \
      git-lfs \
      node \
      rust \
      pyenv-virtualenv \
      starship \
      coreutils \
      lazygit
    brew cask install \
      iterm2 \
      docker \
      google-chrome
    brew tap homebrew/cask-fonts && brew install --cask font-fira-code # For kitty

    echo "Setting up zsh as a default shell: chsh -s /bin/zsh"
    chsh -s /bin/zsh
  fi

  if [[ "$OSTYPE" == linux* ]]; then
    sudo apt update
    sudo apt install -y \
      less \
      fortune \
      mc \
      vim \
      htop \
      wget \
      tmux \
      tree \
      zsh \
      curl \
      dnsutils \
      git-crypt \
      myrepos \
      rar \
      unrar \
      snapd \
      direnv \
      jq \                 # parse json in command line
      xclip \
      bat \                # less with colors
      fonts-firacode \     # kitty
      ripgrep \            # telescope
      python3-pynvim \     
      syncthing \          # my binaries 
      fd-find              # because of nvim telescope
    sudo usermod --shell /bin/zsh $(whoami)
    sudo snap install telegram-desktop firefox postman snapd mqtt-explorer arduino
    
    # syncthing
    sudo curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    sudo apt update && sudo apt install syncthing
    
    # Keybase
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install -y ./keybase_amd64.deb
    rm -f ./keybase_amd64.deb

    # nodejs / NPM / yarn
    curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
    sudo apt install -y nodejs
    sudo npm install --global yarn

    # starship 
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"

    # kitty 
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # My own fonts
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLo "JetBrains Mono Light Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Light/complete/JetBrains%20Mono%20Light%20Nerd%20Font%20Complete.ttf
    fc-cache -f -v

  fi
}

function dotfiles {
  if [[ -d "$DOTFILES" ]]; then
    echo "Symlinking dotfiles from $DOTFILES"
  else
    echo "$DOTFILES does not exist"
    exit 1
  fi

  if [ ! -d "$BACKUP" ]; then
    echo "Creating the backup dotfiles dir: $BACKUP ... "
    mkdir $BACKUP
    echo "Done"
  fi

  if [ -d "~/bin" ]; then
    echo "~/bin already exists. Skipping creation"
  else
    echo "Creating ~/bin"
    mkdir ~/bin
  fi

  if [[ "$OSTYPE" == darwin* ]]; then
    lnFile gitconfig gitconfig 
    lnFile gittemplates gittemplates
    lnFile vimrc vimrc
    lnFile mrconfig mrconfig   
    
    # Tmux 
    lnFile tmux/tmux.conf tmux.conf
    lnFile tmux/tmux.osx.conf tmux.osx.conf

    # hh/hstr
    lnFile hh_blacklist hh_blacklist

    # zsh stuff
    lnFile zsh/zlogout zlogout
    lnFile zsh/zshenv zshenv
    lnFile zsh/zprofile zprofile
    lnFile zsh/zpreztorc zpreztorc
    lnFile zsh/zshrc zshrc
    lnFile zsh/aliases aliases
  fi
  if [[ "$OSTYPE" == linux* ]]; then
    lnFile vim vim
    lnFile i3 i3
    lnFile gnupg gnupg
    lnFile vimrc vimrc 
    lnFile mrconfig mrconfig   
    lnFile irssi irssi 
    lnFile gitconfig gitconfig 
    lnFile gittemplates gittemplates
    lnFile gbp.conf gbp.conf
    
    # Tmux 
    lnFile tmux/tmux.conf tmux.conf
    lnFile tmux/tmux.linux.conf tmux.linux.conf
    
    # zsh stuff
    lnFile zsh/aliases aliases 
    lnFile zsh/zlogout zlogout
    lnFile zsh/zshenv zshenv
    lnFile zsh/zprofile zprofile
    lnFile zsh/zpreztorc zpreztorc
    lnFile zsh/zshrc zshrc
  fi
}

function lnFile {
  if [ -f "$HOME/.$2" ]; then
     BackupFile "$1"
  fi
  echo "Linking '$DOTFILES/$1' to '$HOME/.$2"
  ln -s $DOTFILES/$1 $HOME/."$2"
  echo -e '\E[0;32m'"Done\033[0m"
}

function BackupFile {
   mv $HOME/.$1 $BACKUP/$1
}

case $1 in
  -i|--install)
    echo "Installing the must apps"
    install
  ;;
  -d|--dotfiles)
    echo "Symlinking dotfiles"
    dotfiles
  ;;
  *)
    usage
  ;;
esac
