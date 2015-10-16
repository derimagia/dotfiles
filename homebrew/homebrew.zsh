# Install all casks to /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_BREWFILE=~/.dotfiles/homebrew/Brewfile

if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi
