#!/bin/bash


print_info() {
    ink -l -c yellow "$@"
}


print_error() {
    ink -l -c red "$@"
}

print_status() {
    ink -l -c blue "$@"
}

export DOTFILES=${DOTFILES:-$HOME/.dotfiles/}
export ZDOTDIR="${ZDOTDIR:-"$DOTFILES/config/zsh"}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-~/.config}"
export LOCAL_PREFIX='/usr/local'

get_metadata() {
    OSTYPE=$(uname | tr "[:upper:]" "[:lower:]")
    # If Linux, try to determine specific distribution
    if [[ "$OSTYPE" == "linux" ]]; then
        if [[ -f /etc/lsb-release ]]; then
            OSTYPE=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'// | tr "[:upper:]" "[:lower:]")
        fi
    fi
}

os_function() {
    local os_function="$1_$OSTYPE"

    if ! declare -f $local os_function > /dev/null; then
        print_error "Could not find $1 function for OS '$OSTYPE'"
        exit 1
    fi

    $os_function
}

install_git_ubuntu() {
    sudo apt update
    hash git 2>/dev/null && return
    sudo apt install git
}

install_git_darwin() {
    hash git 2>/dev/null && return

    xcode-select --install &> /dev/null

    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

    sudo xcodebuild -license
}

install_dotfiles() {
    os_function install_git

    if [[ ! -d $DOTFILES ]]; then
        git clone https://github.com/derimagia/dotfiles.git $DOTFILES
    fi

    [[ -d "$XDG_CONFIG_HOME" ]] || ln -s "$DOTFILES/config/" "$XDG_CONFIG_HOME"

    # Link dotfile binaries.
    PATH=$ZDOTDIR/bin/:$PATH
}

install_from_url() {
    local binpath="$LOCAL_PREFIX/bin"
    local name="$1"
    local url="$2"

    curl -sfLo "$binpath/$name" "$url"
    chmod +x "$binpath/$name"
}

setup() {
    os_function setup

    # @TODO: Just add this to binaries in dotfiles
    hash antibody 2>/dev/null || curl -sL 'https://raw.githubusercontent.com/getantibody/installer/master/install' | bash -s

    dot vim
}

setup_darwin() {
    hash brew 2>/dev/null || printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null

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
    echo 'export ZDOTDIR="$XDG_CONFIG_HOME/zsh"' | sudo tee /etc/zshenv >/dev/null

    print_info 'Run `defaults write com.apple.dock persistent-apps -array ""` to kill all apps from the dock'
}

setup_ubuntu() {
    sudo apt install -y \
        software-properties-common apt-transport-https python-software-properties \
        git unzip curl wget \
        zsh neovim

    echo 'export ZDOTDIR=~/.config/zsh' | sudo tee /etc/zsh/zshenv >/dev/null
    chsh -s "$(which zsh)"

    install_from_url 'diff-so-fancy' 'https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy'
}

get_metadata
install_dotfiles
setup
exec zsh
