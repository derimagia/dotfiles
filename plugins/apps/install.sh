#!/bin/bash

UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [[ "$UNAME" == "linux" ]]; then
    if [[ -f /etc/lsb-release ]]; then
        DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'// | tr "[:upper:]" "[:lower:]")
    fi
fi

if [[ $OSTYPE == 'darwin' ]] && ! xcode-select --print-path &> /dev/null; then
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

if [[ $OSTYPE == 'darwin' ]]; then
    hash brew 2>/dev/null || printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
fi

# Link dot files
PATH=$DOTFILES/plugins/utilities/bin/:$PATH
$DOTFILES/plugins/apps/bin/dot-link

if [[ $DISTRO == 'ubuntu' ]]; then
    sudo apt-get install zsh
    zsh_path=$(which zsh)
    chsh -s $zsh_path
    exec $zsh_path
elif [[ $OSTYPE == 'darwin' ]]; then
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

function print_error() {
    ink -l -c red "$@"
}

function print_status() {
    ink -l -c blue "$@"
}

# Install xterm-256color-italic.terminfo
ink -t 2 -c blue "Installing xterm-256color italic terminfo" && { infocmp -1 xterm-256color ; echo "\tsitm=\\E[3m,\n\tritm=\\E[23m,"; } > $DOTFILES/plugins/apps/terminal/xterm-256color.terminfo && tic $DOTFILES/plugins/apps/terminal/xterm-256color.terminfo
