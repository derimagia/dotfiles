# Aliases
alias fs='stat -c "%s Bytes"' # File Size
alias map="xargs -n1"
alias editvar='vared'
alias vim="nvim"
alias v="vim"
alias ag='ag -f --hidden'
alias ccat='vimcat'
alias rename='noglob zmv -W'
alias dk='exec desk .'
alias s='find . -iname'
alias cpp='rsync -WavP --human-readable --progress' # Copy with progress
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # Get external ip

# tmux
alias tmux='tmux -2 -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias ta='tmux attach -d'
alias tnew='tmux new -s'

# dotfile
alias cddot="cd $DOTFILES"
alias dottime='time zsh -ic true';
alias doti="i $DOTFILES"
alias dotc="code $DOTFILES"
alias confc="code $XDG_CONFIG_HOME"
alias confcd="cd $XDG_CONFIG_HOME"
alias brewc="code $HOMEBREW_PREFIX/etc"
alias brewi="i $HOMEBREW_PREFIX/etc"

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
alias g="git"
alias gup='gitup'
alias diffg="git diff --color-words --no-index"
alias dclone="clone -d"

# Global Aliases
alias -g G="| grep -i --"
alias -g P='2>&1 | $PAGER'

# Suffix Aliases
alias -s htm="$BROWSER"
alias -s html="$BROWSER"
alias -s yaml="ccat"
alias -s yml="ccat"
alias -s json="jq ."
alias -s xml="ccat"
alias -s py="python"
alias -s jar="java -jar"
alias -s war="java -jar"
alias -s Dockerfile="docker build - < "

# Url functions
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
alias html2text='w3m -dump -T text/html'

# Aliases for common Drush commands that work in a global context.
alias composer="php -n =composer"
alias ev='drush php-eval'
alias lsa='drush site-alias'
alias dq='drush sql-query'
alias xdrush='XDEBUG_CONFIG="idekey=PHPSTORM" drush'

