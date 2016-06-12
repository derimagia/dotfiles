#!/bin/sh

if ! xcode-select --print-path &> /dev/null; then
    xcode-select --install &> /dev/null

    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

    sudo xcodebuild -license
fi

if [[ ! -d ~/.dotfiles ]]; then
    git clone https://github.com/derimagia/dotfiles.git ~/.dotfiles
fi

source ~/.dotfiles/.zshenv
hash brew 2>/dev/null || printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null

# Link dot files
PATH=$DOTFILES/plugins/utilities/bin/:$PATH
$DOTFILES/plugins/apps/bin/dot-link

# Install ZSH specifically
[[ ! -x $HOMEBREW_PREFIX/bin/zsh ]] && brew install zsh

# Default Shells
HOMEBREW_PREFIX=$(brew --prefix)
sudo bash -c "echo $HOMEBREW_PREFIX/bin/bash >> /etc/shells"
sudo bash -c "echo $HOMEBREW_PREFIX/bin/zsh >> /etc/shells"

finger -k $USER | fgrep -q "Shell: $HOMEBREW_PREFIX/bin/zsh" || chsh -s  $HOMEBREW_PREFIX/bin/zsh

exec $HOMEBREW_PREFIX/bin/zsh

# Run (defaults write com.apple.dock persistent-apps -array "") to kill all apps from the dock
# Run "dot"
