zmodload -F zsh/stat b:zstat

# Global Aliases
alias -g G='| grep -i --'
alias -g P='2>&1 | $PAGER'

# Suffix Aliases
alias -s htm="$BROWSER"
alias -s html="$BROWSER"
alias -s yaml='ccat'
alias -s yml='ccat'
alias -s json='() { file=$1; shift; jq ${@:-"."} "$file" }'
alias -s xml='ccat'
alias -s py='python'
alias -s jar='java -jar'
alias -s war='java -jar'

if [[ $OSTYPE =~ darwin ]] {
	alias -s md='ql'
	alias -s csv='ql'
}

alias fs='stat -c "%s Bytes"' # File Size
alias map="xargs -n1"
alias editvar='vared'
alias ccat='vimcat'
alias s='find . -iname'
alias cpp='rsync -WavP --human-readable --progress' # copy with progress
alias help='run-help'

# ls
alias l='exa -al --git'
alias hidden='() { cd "${1:-$PWD}" && print -lr .* }'

# tmux
alias tmux='tmux -2 -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias ta='tmux attach -d'
alias tnew='tmux new -s'

# opening projects
alias vim="nvim"
alias v="vim"
alias dottime='time zsh -ic true'
alias cdconf="cd $XDG_CONFIG_HOME"
alias confs="${EDITOR:-subl} $XDG_CONFIG_HOME"
alias zshs="${EDITOR:-subl} $ZDOTDIR"
alias localrc="${EDITOR:-subl} $ZDOTDIR/.zlocalrc"

# files and directories
alias rename='noglob zmv -W'

# bookmarks
alias z=jump
alias p="showmarks"

# network
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # external ip
alias iip='ifdata -pN' # internal ip, needs interface

# docker
alias dr="docker"
alias drr="docker run -it --rm"
alias drc="docker-compose"
alias dl='docker ps -lq'
alias dps='docker ps'
alias di='docker images'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias docker-images-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'
alias container-transform='docker run --rm -v $(pwd):/data/ micahhausler/container-transform'

# kube
alias k='kubectl'
alias ku='k config use-context'
alias kc='k config current-context'
alias kcl='k config view -o jsonpath="{.contexts[*].name}" | tr " " "\n"'

alias kg='k get'
alias kl='k logs'

# git
alias g='git'
alias diffg='git diff --color-words --no-index'
alias dclone='clone -d'

# Url functons
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
alias html2text='w3m -dump -T text/html'

# meta
alias laliases='() { alias | grep -E ${1-.} | vimcat | fzf }'
alias lfunctions='() { print -l ${(ok)functions} | grep -E ${1-.} | vimcat | fzf }'

# named directories, allows for e.g. ~c
hash -d c="$XDG_CONFIG_HOME"
