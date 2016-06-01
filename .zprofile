export MANPAGER="less -X"
export FZF_DEFAULT_OPTS="--inline-info"

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'
export MANPATH
export PATH
export BROWSER=$PAGER

bindkey -e

typeset -gU fpath path manpath

if [ -x /usr/libexec/path_helper ]; then
    path=()
    manpath=()
    eval `/usr/libexec/path_helper -s`
fi

path=(
    "$HOME/bin"
    "$GOPATH/bin"
    "$COMPOSER_HOME/vendor/bin"
    "$HOMEBREW_PREFIX/sbin"
    "$HOMEBREW_PREFIX/bin"
    $path
)

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi
