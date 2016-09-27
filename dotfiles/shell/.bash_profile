# .bash_profile

# Load ~/.profile regardless of shell version
if [ -e "$HOME"/.profile ] ; then
    . "$HOME"/.profile
fi

# Load interactive Bash config if it exists
if [[ -e $HOME/.bashrc ]] ; then
    source "$HOME"/.bashrc
fi

# Load login scripts
for config in $HOME/.shellrc/login.d/*.sh; do
  source $config
done

unset -v config
