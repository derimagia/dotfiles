#!/usr/bin/env zsh

TERM="${TERM:-xterm-256color}"
export TZ=:/etc/localtime

# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

if [[ $OSTYPE =~ darwin ]] {
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/Library/Caches"}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/Library"}
} else {
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
}

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem/specs"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
