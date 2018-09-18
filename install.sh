#!/bin/bash

dotfiles="`pwd`/dotfiles"
destination=$HOME
minttyrc=.minttyrc_solarized_light
copy_command="cp -sfR"

function copy_shell
{
  $copy_command $dotfiles/shell/. $destination
}

function copy_git
{
  $copy_command $dotfiles/git/. $destination
}

function copy_tmux
{
  $copy_command $dotfiles/tmux/. $destination
}

function copy_vim
{
  if [ ! -d $destination/.vim ]; then
    mkdir $destination/.vim
  fi
  $copy_command $dotfiles/vim/.vimrc $destination
  $copy_command $dotfiles/vim/.vim/. $destination/.vim
  if [ ! -d $destination/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

function copy_cygwin
{
  if [ `uname -o` = "Cygwin" ]; then
    $copy_command $dotfiles/cygwin/$minttyrc $destination/.minttyrc
  fi
}

function check_rg
{
  command -v rg &> /dev/null
  OUT=$?
  if [ $OUT -eq 0 ]; then
    echo "rg installed."
  else
    echo "rg not found."
  fi
}

function install_vim_plugins
{
  vim +PlugUpdate +qall
}

copy_shell
copy_git
copy_tmux
copy_vim
copy_cygwin
check_rg
install_vim_plugins
