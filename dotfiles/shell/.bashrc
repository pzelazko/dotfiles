# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  /etc/bashrc
fi

# Load bashrc config scripts
for config in "$HOME"/.shellrc/bashrc.d/*.bash ; do
  source "$config"
done

# Load common config scripts
for config in "$HOME"/.shellrc/rc.d/*.sh ; do
  source "$config"
done

unset -v config

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
