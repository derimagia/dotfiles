export MANPAGER='less -FX'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'
export BROWSER=$PAGER

if [[ -x /usr/libexec/path_helper ]]; then
    path=()
    manpath=()
    eval `/usr/libexec/path_helper -s`
fi
