#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install rcmdnk/file/brew-file
fi

brew update # Pull down Taps / Git Repo
brew upgrade # Upgrade Brews

# Update Casks
brew file cask_upgrade -C
brew file update -C --no_appstore
brew clean -C

exit 0
