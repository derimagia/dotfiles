export MANPAGER="less -X"
export FZF_DEFAULT_OPTS="--inline-info"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'

typeset -gU cdpath fpath mailpath manpath path

bindkey -e  # emacs key bindings

if [ -x /usr/libexec/path_helper ]; then
    path=()
    eval `/usr/libexec/path_helper`
fi

path=(
    "$HOME/bin"
    "$GOPATH/bin"
    "$COMPOSER_HOME/vendor/bin"
    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"
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
