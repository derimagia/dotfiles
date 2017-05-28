alias fs='stat -c "%s Bytes"' # File Size
alias map="xargs -n1"
alias editvar='vared'
alias ag='ag -f --hidden'
alias ccat='vimcat'
alias dk='desk .'
alias s='find . -iname'
alias cpp='rsync -WavP --human-readable --progress' # copy with progress
alias help='run-help'

# ls
alias l='exa'

# tmux
alias tmux='tmux -2 -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias ta='tmux attach -d'
alias tnew='tmux new -s'

# opening projects
alias i='idea'
alias vim="nvim"
alias v="vim"
alias dottime='time zsh -ic true'
alias cddot="cd $DOTFILES"
alias doti="i $DOTFILES"
alias dotc="code $DOTFILES"
alias confc="code $XDG_CONFIG_HOME"
alias confcd="cd $XDG_CONFIG_HOME"
alias brewc="code $HOMEBREW_PREFIX/etc"
alias zshc="code $ZDOTHOME"

# files
alias rename='noglob zmv -W'

# network
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # external ip
alias iip='ifdata -pN' # internal ip

# docker
alias dr="docker"
alias dr-run="docker run -it --rm"
alias drc="docker-compose"
alias dl='docker ps -l -q'
alias dps='docker ps'
alias di='docker images'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias docker-images-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'

# git
alias g='git'
alias gup='gitup'
alias diffg='git diff --color-words --no-index'
alias dclone='clone -d'

# Url functions
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
alias html2text='w3m -dump -T text/html'

# composer/drush
alias composer="php -n =composer"
alias ev='drush php-eval'
alias lsa='drush site-alias'
alias dq='drush sql-query'
alias xdrush='XDEBUG_CONFIG="idekey=PHPSTORM" drush'

# Global al
alias -g G='| grep -i --'
alias -g P='2>&1 | $PAGER'

# Suffix Aliases
alias -s htm="$BROWSER"
alias -s html="$BROWSER"
alias -s yaml='ccat'
alias -s yml='ccat'
alias -s json='jq .'
alias -s xml='ccat'
alias -s py='python'
alias -s jar='java -jar'
alias -s war='java -jar'
alias -s Dockerfile='docker build - < '
alias -s md='ql'
alias -s csv='ql'
