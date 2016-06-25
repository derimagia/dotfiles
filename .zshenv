export DOTFILES=$HOME/.dotfiles
export DOTFILES_CACHE_DIR=$HOME/.cache
export HOMEBREW_PREFIX=/usr/local
#export HOMEBREW_FILE_APPSTORE=false
export HOMEBREW_BREWFILE=$DOTFILES/plugins/osx/Brewfile
export HOMEBREW_NO_ANALYTICS=1
export GOPATH=$HOME/dev/go
export COMPOSER_HOME=$DOTFILES/.composer

# Sets SHELL_PLATFORM to simplified OSTYPE ('linux' or 'osx'). Default is full $OSTYPE
export SHELL_PLATFORM=${SHELL_PLATFORM:=${${OSTYPE//${:-*linux*}/linux}//${:-*darwin*}/osx}}\

# Zplug
ZPLUG_HOME=$HOME/.zplug
ZPLUG_REPOS=$ZPLUG_HOME/repos

[[ -f "$HOME/.localrc" ]] && source $HOME/.localrc
