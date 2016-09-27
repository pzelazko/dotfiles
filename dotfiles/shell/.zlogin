# .zlogin

# Load login scripts
for config in $HOME/.shellrc/login.d/*.sh; do
  source $config
done

unset -v config
