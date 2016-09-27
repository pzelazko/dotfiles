#!/bin/bash

destination=$HOME

function install_ohmyzsh
{
  if [ ! -d $destination/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
}

install_ohmyzsh
