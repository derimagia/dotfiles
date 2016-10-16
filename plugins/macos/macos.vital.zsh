[[ $SHELL_PLATFORM == "macos" ]] || return

if [[ -f $HOMEBREW_PREFIX/etc/brew-wrap ]]; then
    source $HOMEBREW_PREFIX/etc/brew-wrap
fi

export HOMEBREW_PREFIX=/usr/local
export HOMEBREW_BREWFILE=$DOTFILES/plugins/macos/Brewfile
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
    $path
)

manpath=(
    $HOMEBREW_PREFIX/share/man
    $manpath
)


