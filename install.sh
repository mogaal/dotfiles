#!/usr/bin/env bash

##############
#### VARS ####
##############

DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BACKUP="$(dirname "$DOTFILES")/dotfiles_old"

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

lnFile vim vim
lnFile vimrc vimrc 
lnFile bashrc bashrc
lnFile bash_vars bash_vars 
lnFile bash_aliases bash_aliases 
lnFile gitconfig gitconfig 
lnFile tmux.conf tmux.conf
