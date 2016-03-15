# Install all casks to /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_BREWFILE=$ZSH/homebrew/Brewfile

if [ -f $HOMEBREW_PREFIX/etc/brew-wrap ];then
  source $HOMEBREW_PREFIX/etc/brew-wrap
fi
