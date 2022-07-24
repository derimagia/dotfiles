# zmv lets you rename files easily
autoload -U zmv
alias mmv='zmv -W' # Rename like: mmv '*.lis' '*.txt'

# Global Aliases
# alias -g G='| grep -i --'
# alias -g P='2>&1 | $PAGER'

# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# alias editvar='vared'
alias cpp='rsync -WavP --human-readable --progress' # copy with progress
alias l='exa --git --all --long --header --icons'
alias dottime='time zsh -ic true'
alias conf='subl $XDG_CONFIG_HOME/conf.sublime-project'

# network
alias eip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com' # external ip
alias eipv6='dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com' # external ip

# meta
alias laliases='() { alias | grep -E ${1-.} | bat | fzf }'
alias lfunctions='() { print -l ${(ok)functions} | grep -E ${1-.} | bat | fzf }'

# Linux aliases
alias ssh='TERM=xterm ssh' # Fix issue with ssh terminal

alias pac='pacman -Qq | fzf --preview "pacman -Qil {}" --layout=reverse --bind "enter:execute(pacman -Qil {} | less)"'
alias pac-installed='comm -23 <(pacman -Qqt | sort) <(pacman -Sqg base base-devel | sort) | fzf --preview "pacman -Qil {}" --layout=reverse --bind "enter:execute(pacman -Qil {} | less)"'

# List explicitly installed from specific repo
alias pac-from-repo='() { comm -12 <(pacman -Qeqn | sort) <(pacman -Sql ${1:-multilib} | sort) }'
