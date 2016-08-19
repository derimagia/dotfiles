#!/usr/bin/env zsh

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
ink -l -c green "Installing/Upgrading Brews..."
brew file update --preupdate --no_appstore -C

ink -l -c green "Installing/Upgrading Casks..."
brew file cask_upgrade -C


gnufiles=(
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin/*
)

manfiles=(
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman/man1/*
)

# Link Man Files that aren't linked by default
symlink-files -q "$gnufiles" "$HOMEBREW_PREFIX/bin"
symlink-files -q "$manfiles" "$HOMEBREW_PREFIX/share/man/man1"
