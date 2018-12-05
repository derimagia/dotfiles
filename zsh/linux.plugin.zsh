[[ $OSTYPE =~ linux ]] || return

export BROWSER='google-chrome-stable'

alias open='xdg-open'
alias o='open'
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
