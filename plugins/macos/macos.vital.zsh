[[ $OSTYPE =~ darwin ]] || return

export HOMEBREW_PREFIX=/usr/local
export HOMEBREW_NO_ANALYTICS=1

# Add these in the vital file since we want them before our own paths
fpath=(
    $HOMEBREW_PREFIX/share/zsh/site-functions
    $HOMEBREW_PREFIX/share/zsh-completions
    $fpath
)

path=(
    $HOMEBREW_PREFIX/sbin
    $HOMEBREW_PREFIX/bin
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
    $path
)

manpath=(
    $HOMEBREW_PREFIX/share/man
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman
    /usr/local/opt/findutils/share/man
    $manpath
)

