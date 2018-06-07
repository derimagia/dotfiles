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
alias k='kubectl'

# git
alias g='git'
alias diffg='git diff --color-words --no-index'
alias dclone='clone -d'

# Url functons
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
alias html2text='w3m -dump -T text/html'

# meta
alias laliases='() { alias | grep -E ${1-.} | vimcat | fzf-tmux }'
alias lfunctions='() { print -l ${(ok)functions} | grep -E ${1-.} | vimcat | fzf-tmux }'

# named directories, allows for e.g. ~c
hash -d c="$XDG_CONFIG_HOME"

# XDG_CONFIG
alias aws='$XDG_CONFIG_HOME/aws/config" aws'
alias ansible='$XDG_CONFIG_HOME/ansible/ansible.cfg ansible'
alias composer='COMPOSER_HOME="$COMPOSER_HOME" COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer" php -n =composer'
alias deis='DEIS_PROFILE="$XDG_CONFIG_HOME/deis/config.json" deis'
alias helm='HELM_HOME="$XDG_CONFIG_HOME/helm" helm'
alias htop='HTOPRC="$XDG_CONFIG_HOME/htop/htoprc" htop'
alias http='HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie" http'
alias pip='PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf" pip'
alias redis='REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/history" redis'
alias terminus='TERMINUS_PLUGINS_DIR="$XDG_DATA_HOME/terminus/plugsins" TERMINUS_CACHE_DIR="$XDG_CACHE_HOME/terminus" terminus'
alias tig='TIGRC_USER="$XDG_CONFIG_HOME/tig/tigrc"'
alias tmux='TMUX_PLUGIN_MANAGER_PATH="$XDG_CONFIG_HOME/tmux/plugins" tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias vagrant='VAGRANT_DOTFILE_PATH="$XDG_DATA_HOME/vagrant" VAGRANT_HOME="$XDG_DATA_HOME/vagrant" vagrant'
