export MANPAGER="less -X"
export FZF_DEFAULT_OPTS="--inline-info"

export BROWSER='open'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'

bindkey -e  # emacs key bindings

typeset -gU fpath path

if [ -x /usr/libexec/path_helper ]; then
    path=()
    eval `/usr/libexec/path_helper`
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
