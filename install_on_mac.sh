#!/bin/bash

dotfiles="`pwd`/dotfiles"
destination="$HOME"
copy_command="ln -fs"

function copy_shell
{
  echo "copying shell files"
  $copy_command $dotfiles/shell/.* $destination
  echo "shell files copied"
}

function copy_git
{
  echo "copying git files"
  $copy_command $dotfiles/git/.gitconfig $destination
  echo "git files copied"
}

function copy_tmux
{
  echo "copying tmux files"
  $copy_command $dotfiles/tmux/.* $destination
  echo "tmux files copied"
}

function copy_vim
{
  echo "copying vim files"
  if [ ! -d $destination/.vim ]; then
    mkdir $destination/.vim
  fi
  $copy_command $dotfiles/vim/.vimrc $destination
  $copy_command $dotfiles/vim/.vim/* $destination/.vim
  if [ ! -d $destination/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  echo "vim files copied"
}

function install_vim_plugins
{
  vim +PlugUpdate +qall
}

echo "Installing dotfiles on Mac"
echo "source: $dotfiles"
echo "destination: $destination"

copy_shell
copy_git
copy_tmux
copy_vim
install_vim_plugins
