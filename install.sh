#!/usr/bin/env bash

##############
#### VARS ####
##############

DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BACKUP="$(dirname "$DOTFILES")/dotfiles_old"

# Binaries
TERRAFORM_VERSION='0.11.14'
TERRAFORM_NEW_VERSION='0.12.14'

##################
#### FUNCTIONS ###
##################

display_help() {
    echo "Usage: $0 [option]" >&2
    echo
    echo "   -i, --install-apps         Install the must apps"
    echo "   -d, --dotfiles             Install the dotfiles "
    echo
    exit 1
}

function install {
  if [[ "$OSTYPE" == darwin* ]]; then
    brew install jq python htop tree mr wget reattach-to-user-namespace tmux hh gpg git-crypt bat zsh direnv git-lfs node
    brew cask install iterm2 docker google-chrome
    echo "Setting up zsh as a default shell: chsh -s /bin/zsh"
    chsh -s /bin/zsh
  fi
  if [[ "$OSTYPE" == linux* ]]; then
    sudo apt update
    sudo apt install less mc vim htop wget git tmux tree zsh curl dnsutils git-crypt myrepos rar unrar snapd direnv
    sudo snap install node --classic
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
    lnFile zsh/zlogin zlogin
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
    lnFile zsh/zlogin zlogin
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
  -e|--install-extras)
    echo "Installing the extra-apps"
    install
  ;;
  -d|--dotfiles)
    echo "Symlinking dotfiles"
    dotfiles
  ;;
  *)
    display_help
  ;;
esac
