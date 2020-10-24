[[ $OSTYPE =~ linux ]] || return

export BROWSER='google-chrome-stable'

alias open='xdg-open'
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'

alias pac='pacman -Qq | fzf --preview "pacman -Qil {}" --layout=reverse --bind "enter:execute(pacman -Qil {} | less)"'
alias pac-installed='comm -23 <(pacman -Qqt | sort) <(pacman -Sqg base base-devel | sort) | fzf --preview "pacman -Qil {}" --layout=reverse --bind "enter:execute(pacman -Qil {} | less)"'

# List explicitly installed from specific repo
alias pac-from-repo='() { comm -12 <(pacman -Qeqn | sort) <(pacman -Sql ${1:-multilib} | sort) }'
