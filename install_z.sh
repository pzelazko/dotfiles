#!/bin/bash

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

install_z
