shopt -s histappend               # append history to ~\.bash_history when exiting shell
export HISTCONTROL=erasedups:ignoreboth  # erase all previous matching lines; ignore duplicates and lines beginning with spaces
export HISTSIZE=100000                   # save 100.000 items in history
export HISTFILESIZE=$HISTSIZE            # store as many entries in file as in memory
export HISTFILE=$HOME/.history           # share history file with zsh
