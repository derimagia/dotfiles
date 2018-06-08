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

export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export COMPOSER_HOME="$XDG_DATA_HOME/composer"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export TERMINFO="$XDG_CONFIG_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export TMUX_PLUGIN_MANAGER_PATH="$XDG_CONFIG_HOME/tmux/plugins"
export VAGRANT_DOTFILE_PATH="$XDG_DATA_HOME/vagrant"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"

# history files
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql/history"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"
export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/history"

# Kubectl
export KUBECONFIG="$HOME/.kube/config:"${(j;:;):-$(echo $XDG_CONFIG_HOME/kube/*.yaml(N))}
