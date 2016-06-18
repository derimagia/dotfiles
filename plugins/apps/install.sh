#!/bin/sh

# Get Distro
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    DISTRO=$DISTRIB_ID
fi

function is_linux() {
    [[ $OSTYPE =~ 'linux' ]]
}

function is_osx() {
    [[ $OSTYPE =~ 'darwin' ]]
}

function is_ubuntu() {
    is_linux && [[ $DISTRO =~ 'Ubuntu' ]]
}

if is_osx && ! xcode-select --print-path &> /dev/null; then
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

if is_osx; then
    hash brew 2>/dev/null || printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
fi

# Link dot files
PATH=$DOTFILES/plugins/utilities/bin/:$PATH
$DOTFILES/plugins/apps/bin/dot-link

if is_ubuntu; then
    sudo apt-get install zsh
    zsh_path=$(which zsh)
    chsh -s $zsh_path
    exec $zsh_path
elif is_osx; then
    HOMEBREW_PREFIX=$(brew --prefix)
    # Install ZSH specifically

    [[ ! -x $HOMEBREW_PREFIX/bin/zsh ]] && brew install zsh

    # Default Shells
    sudo bash -c "echo $HOMEBREW_PREFIX/bin/bash >> /etc/shells"
    sudo bash -c "echo $HOMEBREW_PREFIX/bin/zsh >> /etc/shells"

    finger -k $USER | fgrep -q "Shell: $HOMEBREW_PREFIX/bin/zsh" || chsh -s $HOMEBREW_PREFIX/bin/zsh

    exec $HOMEBREW_PREFIX/bin/zsh
    # Run (defaults write com.apple.dock persistent-apps -array "") to kill all apps from the dock
fi

# Run "dot"
