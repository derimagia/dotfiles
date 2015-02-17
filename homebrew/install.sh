#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Upgrade any already-installed formulae
brew upgrade

brew tap homebrew/dupes
brew tap homebrew/php
brew tap homebrew/versions

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install some other useful utilities like `sponge`
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --default-names

brew install grc
brew install spark

# Install wget with IRI support
brew install wget --enable-iri

# Install other useful binaries
brew install ack
#install exiv2
brew install git
brew install git-extras
brew install git-flow
brew install imagemagick --with-webp
brew install ffmpeg
brew install pv
brew install rename
brew install tree
#install zopfli
brew install redis
brew install composer
brew install nmap
brew install mtr
brew install aircrack-ng
brew install cowsay
brew install fortune
brew install python
brew install webkit2png
brew install pngcheck
brew install bropages

# Javascript / Web
brew install spidermonkey
brew install v8
brew install phantomjs
brew install sassc

brew install lastpass-cli --with-pinentry

# Databases
brew install mysql
brew install mongodb
brew install postgresql
brew install php53
brew install php55

brew install caskroom/cask/brew-cask

$ZSH/homebrew/casks.sh

# Remove outdated versions from the cellar
brew cleanup

exit 0
