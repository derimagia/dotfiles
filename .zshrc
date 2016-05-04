#!/usr/bin/env zsh

# Init Zplug
ZPLUG_HOME=$HOME/.zplug
{ [[ -d $ZPLUG_HOME ]] || git clone https://github.com/zplug/zplug $ZPLUG_HOME }; source $ZPLUG_HOME/zplug

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
zplug rcmdnk/homebrew-file, as:plugin, use:etc/brew-wrap; zplug rcmdnk/homebrew-file, as:command, use:bin/brew-file
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-syntax-highlighting, nice:10  # @TODO Autosuggestions and Syntax Highlighting conflict when you reload zsh config files using . ~/.zshrc.

#zplug check || zplug install
#export ZPLUG_USE_CACHE=false &&
#zplug load --verbose
zplug load

DOTFILES_LOADED=1