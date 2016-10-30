#!/usr/bin/env zsh

[[ $OSTYPE =~ darwin ]] || exit 34

# @TODO - Having issues with running from ~
cd $DOTFILES

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
ink -l -c green -- "-- brew update"
brew update

ink -l -c green -- "-- brew upgrade"
brew upgrade

ink -l -c green -- "-- brew bundle"
brew bundle --global

gnufiles=(
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin/*
)

manfiles=(
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman/man1/*
)

# Link Man Files that aren't linked by default
symlink-files -q "$gnufiles" "$HOMEBREW_PREFIX/bin"
symlink-files -q "$manfiles" "$HOMEBREW_PREFIX/share/man/man1"
