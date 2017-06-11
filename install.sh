#!/bin/bash

print_error() {
    ink -l -c red "$@"
}

print_status() {
    ink -l -c blue "$@"
}

export DOTFILES=${DOTFILES-$HOME/.dotfiles/}

OSTYPE=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [[ "$OSTYPE" == "linux" ]]; then
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

if [[ ! -d $DOTFILES ]]; then
    git clone https://github.com/derimagia/dotfiles.git $DOTFILES
fi

# Set temp zdotdir
source $DOTFILES/config/zsh/.zshenv
export ZDOTDIR="$DOTFILES/config/zsh"

if [[ $OSTYPE == 'darwin' ]]; then
    hash brew 2>/dev/null || printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
fi

# Link dot files
PATH=$ZDOTDIR/bin/:$PATH

print_status "Symlinking config"
[[ -d $HOME/.config ]] || ln -sT $DOTFILES/config $HOME/.config

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

    # We set this here and in the launchctl environment file. Ideally we could remove this one.
    print_status "Adding ZDOTDIR to /etc/zshenv"
    #@TODO This is global for everyone, see https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
    sudo sed -i '/export ZDOTDIR/ d' /etc/zshenv

    echo 'export ZDOTDIR="$XDG_CONFIG_HOME/zsh"' | sudo tee /etc/zshenv >/dev/null

    print -l 'Run `defaults write com.apple.dock persistent-apps -array ""` to kill all apps from the dock'
    exec $HOMEBREW_PREFIX/bin/zsh
fi
