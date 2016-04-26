#!/usr/bin/env zsh

export DOTFILES=$HOME/.dotfiles
export DOTFILES_CACHE_DIR=$HOME/.cache
export HOMEBREW_PREFIX=/usr/local
export HOMEBREW_CASK_OPTS="--appdir=/Applications" # Install all casks to /Applications
export HOMEBREW_BREWFILE=$DOTFILES/apps/Brewfile
export HOMEBREW_PREFIX=/usr/local
export GHQ_ROOT=$HOME/dev/src
export GOPATH=$HOME/dev/go
export MANPAGER="most"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
export FZF_DEFAULT_OPTS="--inline-info"
export COMPOSER_HOME=$HOME/.composer

[[ -f `/usr/libexec/java_home` ]] && export JAVA_HOME="$(/usr/libexec/java_home)"
[[ -f "$HOME/.localrc" ]] && source $HOME/.localrc

PATH="$GOPATH/bin:$HOME/bin:$COMPOSER_HOME/vendor/bin:$PATH" # GO / Composer Dirs
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH" # Throw Coreutils at front of system binaries
PATH="./bin:$PATH" # ./bin

# zplug
[[ -d ~/.zplug ]] || git clone https://github.com/b4b4r07/zplug ~/.zplug

source $HOME/.zplug/zplug

export ZPLUG_USE_CACHE=false # For Debugging


zplug $HOMEBREW_PREFIX/opt/fzf/shell, of:completion.zsh, from:local
zplug $DOTFILES/zsh-plugins, of:'**/*'.zsh, from:local
zplug $DOTFILES/zsh-plugins, as:command, of:'**/bin/**/*', from:local

zplug supercrabtree/k
zplug chriskempson/base16-shell, of:base16-ocean.dark.sh

# Themes
zplug mafredri/zsh-async, nice:2
zplug sindresorhus/pure, nice:3

# Packages
zplug $HOMEBREW_PREFIX/etc, of:brew-wrap, from:local
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-syntax-highlighting, nice:10, if:'[[ -z $DOTFILES_LOADED ]]' # Run Last
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions, if:'[[ -z $DOTFILES_LOADED ]]' # @TODO Autosuggestions and Syntax Highlighting conflict when you reload zsh config files using . ~/.zshrc.

if ! zplug check; then
    zplug install
fi

zplug load

#TODO: Is there a better way to do this?
if [[ -n `which fasd` ]]; then
  eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
fi

DOTFILES_LOADED=1