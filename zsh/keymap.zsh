#!/usr/bin/env bash

bindkey -e  # emacs key bindings

autoload -U edit-command-line
zle -N edit-command-line

expand-aliases() {
    unset 'functions[_expand-aliases]'
    functions[_expand-aliases]=$BUFFER
    (($+functions[_expand-aliases])) &&
    BUFFER=${functions[_expand-aliases]#$'\t'} &&
    CURSOR=$#BUFFER
}

zle -N expand-aliases

bindkey '^ ' magic-space           # control-space to bypass completion
bindkey -M isearch ' ' magic-space # normal space during search

bindkey '\ev' edit-command-line # Vi Mode
bindkey '\ee' expand-aliases

zmodload zsh/terminfo
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down
