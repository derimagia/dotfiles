export MANPAGER='less -X'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'
export BROWSER=$PAGER

bindkey -e

if [ -x /usr/libexec/path_helper ]; then
    path=()
    manpath=()
    eval `/usr/libexec/path_helper -s`
fi
