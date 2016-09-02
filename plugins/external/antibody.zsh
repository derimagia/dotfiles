#!/usr/bin/env zsh

dir=${0:a:h}

antibody bundle < $dir/plugins.txt > $DOTFILES_CACHE_DIR/antibody-plugins.sh && source $DOTFILES_CACHE_DIR/antibody-plugins.sh

# This needs to run after sourcing syntax-highlighting.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
