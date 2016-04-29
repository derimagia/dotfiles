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

for plugin in utilities android docker git prompt terminal tmux; do
    plugin_path=$DOTFILES/zsh-plugins/$plugin

    zplug $plugin_path, use:"$plugin.vital.zsh", from:local, nice:-1 # Load Vitals First
    zplug $plugin_path, use:"$plugin.plugin.zsh", from:local, nice:3
    [[ -d $plugin_path/bin ]] && zplug $plugin_path, use:"$plugin/bin", from:local
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
zplug zsh-users/zsh-autosuggestions # @TODO Autosuggestions and Syntax Highlighting conflict when you reload zsh config files using . ~/.zshrc.
zplug zsh-users/zsh-syntax-highlighting, nice:10

zplug check || zplug install

#export ZPLUG_USE_CACHE=false # For Debugging
zplug load

DOTFILES_LOADED=1