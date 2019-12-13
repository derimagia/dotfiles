[[ $OSTYPE =~ linux ]] || return

export BROWSER='google-chrome-stable'

alias open='xdg-open'
alias nvidia-settings='sudo nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
