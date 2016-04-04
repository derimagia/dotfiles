#!/usr/bin/env bash
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line

bindkey '^v' edit-command-line # Vi Mode

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

function globalias() {
  if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
   zle _expand_alias
   zle expand-word
  fi
  zle self-insert
}

bindkey -e  # emacs key bindings

zle -N globalias

bindkey '^ ' magic-space           # control-space to bypass completion
bindkey -M isearch ' ' magic-space # normal space during search

bindkey '^v' edit-command-line # Vi Mode
