#!/bin/bash

destination=$HOME

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
  cd ..
  rm -rf tmp
}

install_z
