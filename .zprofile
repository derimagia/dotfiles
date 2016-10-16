export MANPAGER='less -X'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'
export BROWSER=$PAGER

bindkey -e

typeset -gU fpath path manpath

if [ -x /usr/libexec/path_helper ]; then
    path=()
    manpath=()
    eval `/usr/libexec/path_helper -s`
fi

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

export TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi
