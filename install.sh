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
  if [ ! -d $destination/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
}

function copy_cygwin
{
  if [ `uname -o` = "Cygwin" ]; then
    $copy_command $dotfiles/cygwin/$minttyrc $destination/.minttyrc
  fi
}

function check_ag
{
  command -v ag &> /dev/null
  OUT=$?
  if [ $OUT -eq 0 ]; then
    echo "ag installed."
  else
    echo "ag not found."
  fi
}

function install_vim_plugins
{
  vim +PluginUpdate +qall
}

function install_z
{
  if [ -f $destination/.shellrc/rc.d/z.sh ]; then
    return
  fi
  mkdir tmp
  cd tmp
  git clone https://github.com/rupa/z.git
  chmod +x z/z.sh
  cp z/z.sh $destination/.shellrc/rc.d/
  sudo cp z/z.1 /usr/local/man/man1/
  cd ..
  rm -rf tmp
}

copy_shell
copy_git
copy_tmux
copy_vim
copy_cygwin
check_ag
install_vim_plugins
install_z
