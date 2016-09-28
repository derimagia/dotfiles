#!/usr/bin/env zsh

dir=${0:a:h}

if [[ ! -f $DOTFILES_CACHE_DIR/antibody-plugins.sh ]]; then
    # @TODO: Fork antibody, paths are kind of obnoxious
    echo "ANTIBODY_PATH='$(antibody p)'" > $DOTFILES_CACHE_DIR/antibody-plugins.sh
    antibody bundle < $dir/plugins.txt >> $DOTFILES_CACHE_DIR/antibody-plugins.sh
fi

source $DOTFILES_CACHE_DIR/antibody-plugins.sh

# This needs to run after sourcing syntax-highlighting.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
