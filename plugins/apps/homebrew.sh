#!/bin/zsh

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
    echo "Installing Homebrew."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install rcmdnk/file/brew-file
fi


brew file update --preupdate --no_appstore -C
brew file cask_upgrade -C


gnufiles=($HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin/*)
manfiles=($HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman/man1/*)

# Link Man Files that aren't linked by default
symlink-files "$gnufiles" "$HOMEBREW_PREFIX/bin"
symlink-files "$manfiles" "$HOMEBREW_PREFIX/share/man/man1"

exit 0
