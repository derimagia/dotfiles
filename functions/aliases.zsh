#!/usr/bin/env bash
alias reload!='. ~/.zshrc'
alias st='stree'
alias g="git"
alias o="open"
alias androidem='emulator @Nexus_6P_API_23'
alias androidemproxy='emulator @Nexus_6P_API_23 -http-proxy http://`ipconfig getifaddr en0`:8888'
alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # Git Root
alias fs='stat -c "%s Bytes"' # File Size
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash; sudo rm /private/var/vm/sleepimage"
alias ccat='pygmentize -O style=monokai -f console256 -g'
alias ls='ls -AFh --color --group-directories-first'
alias l='k -Ah'
alias cask='brew cask'
alias map="xargs -n1"
alias mou="open /Applications/Mou.app" # Mou!
alias time="command time" # I never want the builtin
alias man="mangle" # This should be a drop-in change, let's me do "man ls -A"
alias docker="grc docker"
alias docker-machine="grc docker-machine"
alias gg="ghq -p -u"
alias docker-images-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'
alias docker-clean-containers='docker ps -aqf status=exited | xargs -r docker rm -v'
alias docker-clean-images='docker images -aqf dangling=true | xargs -r docker rmi'
alias docker-clean-volumes='docker volume ls -qf dangling=true | xargs -r docker volume rm'

# tmux
alias tmux='tmux -2'
alias ta='tmux attach -d'
alias tnew='tmux new -s'
alias tls='tmux ls'
alias tkill='tmux kill-session -t'
alias tmn='tmux -CC new -As $(basename $(pwd))'

# Docker

alias dl="docker ps -l -q"
alias dps="docker ps"
alias di="docker images"
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
