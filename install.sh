#!/usr/bin/env bash

##############
#### VARS ####
##############

DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BACKUP="$(dirname "$DOTFILES")/dotfiles_old"

##################
#### FUNCTIONS ###
##################

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

# Create ~/bin in case it doesn't exist
if [[ -d "~/bin" ]]; then
  echo "~/bin already exists. Skipping creation"
else
  echo "Creating ~/bin"
  mkdir ~/bin
fi

# Things to install in base of the OS
if [[ "$OSTYPE" == darwin* ]]; then
  lnFile gitconfig gitconfig 
  lnFile vimrc vimrc 
  
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
  lnFile irssi irssi 
  lnFile gitconfig gitconfig 
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


