#!/usr/bin/env zsh

export DOTFILES=$HOME/.dotfiles
export DOTFILES_CACHE_DIR=$HOME/.cache
export HOMEBREW_PREFIX=/usr/local
export HOMEBREW_CASK_OPTS="--appdir=/Applications" # Install all casks to /Applications
export HOMEBREW_BREWFILE=$DOTFILES/apps/Brewfile
export HOMEBREW_NO_ANALYTICS=1
export GHQ_ROOT=$HOME/dev/src
export GOPATH=$HOME/dev/go
export MANPAGER="less -X"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
export FZF_DEFAULT_OPTS="--inline-info"
export COMPOSER_HOME=$HOME/.composer

[[ -f "$HOME/.localrc" ]] && source $HOME/.localrc

PATH="$GOPATH/bin:$HOME/bin:$COMPOSER_HOME/vendor/bin:$PATH" # GO / Composer Dirs
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH" # Throw Coreutils at front of system binaries
PATH="./bin:$PATH" # ./bin

# Init Zplug
export ZPLUG_HOME=$HOME/.zplug
{ [[ -d $ZPLUG_HOME ]] || git clone https://github.com/b4b4r07/zplug $ZPLUG_HOME }; source $ZPLUG_HOME/zplug

zplugs=() # Reset zplugs
for plugin_path in $DOTFILES/zsh-plugins/*; do
    vital_paths=($plugin_path/*.vital.zsh(N-))
    autoload_files=($plugin_path/autoload/*(N-))

    zplug $plugin_path, use:'*.plugin.zsh', as:plugin, nice:3, from:local # Main Plugin
    [[ -n $vital_paths ]] && zplug $plugin_path, use:'*.vital.zsh', nice:-1, from:local # Vital Files First
    [[ -d $plugin_path/bin ]] && zplug $plugin_path, as:command, use:"bin/*", from:local
    [[ -n $autoload_files ]] && fpath+=($plugin_path/autoload) && autoload_filenames=${(@)autoload_files:t} && autoload -Uz ${=autoload_filenames}
done

[[ -f $HOMEBREW_PREFIX/opt/fzf/shell ]] && zplug $HOMEBREW_PREFIX/opt/fzf/shell, use:completion.zsh, from:local
zplug supercrabtree/k
zplug chriskempson/base16-shell, use:base16-ocean.dark.sh

# Themes
zplug mafredri/zsh-async, nice:-1 # Dependency for a few things, so load early
zplug sindresorhus/pure, on:mafredri/zsh-async

# Packages
zplug $HOMEBREW_PREFIX/etc, use:brew-wrap, from:local
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-syntax-highlighting, nice:10  # @TODO Autosuggestions and Syntax Highlighting conflict when you reload zsh config files using . ~/.zshrc.

#export ZPLUG_USE_CACHE=false && zplug load --verbose

#zplug check || zplug install
#export ZPLUG_USE_CACHE=false &&
#zplug load --verbose
zplug load

export DOTFILES_LOADED=1