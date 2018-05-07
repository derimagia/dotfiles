#!/usr/bin/env zsh

if [[ $OSTYPE =~ darwin ]] {
  export MANPAGER='vimpager'
  export PAGER='vimpager'
}
export EDITOR='nvim'
export VISUAL='$EDITOR'
export LANG='en_US.UTF-8'
