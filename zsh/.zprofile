#!/usr/bin/env zsh


if [[ $OSTYPE =~ darwin ]] {
  export MANPAGER='vimpager'
  export PAGER='vimpager'
}
export EDITOR='vim'
export VISUAL='vim'
export LANG='en_US.UTF-8'
