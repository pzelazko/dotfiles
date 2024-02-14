# .zshrc

# Load zsh config scripts
for config in "$HOME"/.shellrc/zshrc.d/*.zsh ; do
  source "$config"
done

# Load common config scripts
for config in "$HOME"/.shellrc/rc.d/*.sh ; do
  source "$config"
done

unset -v config

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
