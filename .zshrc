#!/usr/bin/env zsh

export DOTFILES=$HOME/.dotfiles
export DOTFILES_CACHE_DIR=$HOME/.cache
export HOMEBREW_PREFIX=/usr/local
export HOMEBREW_CASK_OPTS="--appdir=/Applications" # Install all casks to /Applications
export HOMEBREW_BREWFILE=$DOTFILES/apps/Brewfile
export HOMEBREW_NO_ANALYTICS=1
export GHQ_ROOT=$HOME/dev/src
export GOPATH=$HOME/dev/go
export MANPAGER="most"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
export FZF_DEFAULT_OPTS="--inline-info"
export COMPOSER_HOME=$HOME/.composer


[[ -f "/usr/libexec/java_home" ]] && export JAVA_HOME="$(/usr/libexec/java_home)"
[[ -f "$HOME/.localrc" ]] && source $HOME/.localrc

PATH="$GOPATH/bin:$HOME/bin:$COMPOSER_HOME/vendor/bin:$PATH" # GO / Composer Dirs
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH" # Throw Coreutils at front of system binaries
PATH="./bin:$PATH" # ./bin

# zplug
[[ -d ~/.zplug ]] || git clone https://github.com/b4b4r07/zplug ~/.zplug

source $HOME/.zplug/zplug

zplugs=() # Reset zplugs
for plugin_path in $DOTFILES/zsh-plugins/*; do
    vital_paths=($plugin_path/*.vital.zsh(N-))
    autoload_files=($plugin_path/autoload/*(N-))

    zplug $plugin_path, use:'*.plugin.zsh', as:plugin, nice:3, from:local # Main Plugin
    [[ -n $vital_paths ]] && zplug $plugin_path, use:'*.vital.zsh', nice:-1, from:local # Vital Files First
    [[ -d $plugin_path/bin ]] && zplug $plugin_path, as:command, use:"bin", from:local
    [[ -n $autoload_files ]] && fpath+=($plugin_path/autoload) && autoload -Uz ${autoload_files:t}
done

[[ -f $HOMEBREW_PREFIX/opt/fzf/shell ]] && zplug $HOMEBREW_PREFIX/opt/fzf/shell, use:completion.zsh, from:local
zplug supercrabtree/k
zplug chriskempson/base16-shell, use:base16-ocean.dark.sh

# Themes
zplug mafredri/zsh-async, nice:2
zplug sindresorhus/pure, nice:3

# Packages
zplug $HOMEBREW_PREFIX/etc, use:brew-wrap, from:local
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
[[ -z "$DOTFILES_LOADED" ]] && zplug zsh-users/zsh-syntax-highlighting, nice:10  # @TODO Autosuggestions and Syntax Highlighting conflict when you reload zsh config files using . ~/.zshrc.

#export ZPLUG_USE_CACHE=false && zplug load --verbose

#zplug check || zplug install
zplug load

export DOTFILES_LOADED=1