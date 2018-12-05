zmodload -F zsh/stat b:zstat

# Global Aliases
alias -g G='| grep -i --'
alias -g P='2>&1 | $PAGER'

# Suffix Aliases
alias -s htm='$BROWSER'
alias -s html='$BROWSER'
alias -s yaml='bat'
alias -s yml='bat'
alias -s json='() { file=$1; shift; jq ${@:-"."} "$file" }'
alias -s xml='bat'
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
alias s='find . -iname'
alias cpp='rsync -WavP --human-readable --progress' # copy with progress
alias help='run-help'

# ls
alias l='exa -al --git'
alias hidden='() { cd "${1:-$PWD}" && print -lr .* }'

# opening projects
alias vim='nvim'
alias v="vim"
alias dottime='time zsh -ic true'
alias cdconf="cd $XDG_CONFIG_HOME"
alias confs="$VISUAL $XDG_CONFIG_HOME"
alias zshs="$VISUAL $ZDOTDIR"
alias localrc="$VISUAL $ZDOTDIR/.zlocalrc"

# files and directories
alias rename='noglob zmv -W'

# network
alias eip='dig +short myip.opendns.com @resolver1.opendns.com' # external ip
alias iip='ifdata -pN' # internal ip, needs interface

# docker
alias dr="docker"
alias drr="docker run -it --rm"
alias drc="docker-compose"
alias dps='docker ps'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias docker-images-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'
alias container-transform='docker run --rm -v $(pwd):/data/ micahhausler/container-transform'

# kube
alias kubectl='kubectl --cache-dir="$XDG_CACHE_HOME/kube/http"'
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

# meta
alias laliases='() { alias | grep -E ${1-.} | bat | fzf }'
alias lfunctions='() { print -l ${(ok)functions} | grep -E ${1-.} | bat | fzf }'

# named directories, allows for e.g. ~c
hash -d c="$XDG_CONFIG_HOME"
