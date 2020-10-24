zmodload -F zsh/stat b:zstat

# Global Aliases
# alias -g G='| grep -i --'
# alias -g P='2>&1 | $PAGER'

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

# alias editvar='vared'
alias cpp='rsync -WavP --human-readable --progress' # copy with progress
alias help='run-help'

# ls
alias l='exa -laF --git'
alias hidden='() { cd "${1:-$PWD}" && print -lr .* }'

# opening
alias o='open'
alias v="vim"
alias dottime='time zsh -ic true'
alias conf='subl $XDG_CONFIG_HOME/conf.sublime-project'

# default to current dir
(( $+commands[subl] )) && alias subl='() { subl ${1:-.} }'
(( $+commands[idea] )) && alias idea='() { idea ${1:-.} }'
(( $+commands[code] )) && alias code='() { code ${1:-.} }'

# Example: mmv *.c.orig orig/*.c
alias mmv='autoload -Uz zmv && noglob zmv -W'

# network
alias eip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com' # external ip
alias eipv6='dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com' # external ip

# docker
if (( $+commands[docker] )); then
	alias dr="docker"
	alias drr="docker run -it --rm"
	alias drc="docker-compose"
	alias dps='docker ps'
	alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
	alias docker-images-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'
	alias container-transform='docker run --rm -v $(pwd):/data/ micahhausler/container-transform'
fi

# kube
if (( $+commands[kubectl] )); then
	alias kubectl='kubectl --cache-dir="$XDG_CACHE_HOME/kube/http"'
	alias k='kubectl'
	alias ku='k config use-context'
	alias kc='k config current-context'
	alias kcl='k config view -o jsonpath="{.contexts[*].name}" | tr " " "\n"'
	alias kg='k get'
	alias kl='k logs'
fi

# git
alias g='git'
alias gdiff='git diff --color-words --no-index'

# Url functons
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'

# meta
alias laliases='() { alias | grep -E ${1-.} | bat | fzf }'
alias lfunctions='() { print -l ${(ok)functions} | grep -E ${1-.} | bat | fzf }'

# moving around
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# named directories, allows for e.g. ~c
hash -d c="$XDG_CONFIG_HOME"
