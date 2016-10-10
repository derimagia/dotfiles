#!/usr/bin/env zsh

# Make sure we have antibody
if (( ! $+commands[antibody] )); then
    curl -s https://raw.githubusercontent.com/getantibody/installer/master/install | bash -s
fi

if [[ ! -s $DOTFILES_CACHE_DIR/antibody-plugins-vital.sh ]]; then
    antibody bundle mafredri/zsh-async > $DOTFILES_CACHE_DIR/antibody-plugins-vital.sh
fi

source $DOTFILES_CACHE_DIR/antibody-plugins-vital.sh
