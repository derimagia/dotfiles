#!/usr/bin/env zsh

TERM=${TERM:-xterm-256color}

# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

if [[ $OSTYPE =~ darwin ]] {
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/Library/Caches}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/Library}
} else {
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
}

export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export BOOKMARKS_FILE="$XDG_DATA_HOME/zsh/bookmarks"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export COMPOSER_HOME="$XDG_DATA_HOME/composer"
export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"
export DESK_DESKS_DIR="$XDG_DATA_HOME/desks"
export DEIS_PROFILE="$XDG_CONFIG_HOME/deis/config.json"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem/specs"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export HTOPRC="$XDG_CONFIG_HOME/htop/htoprc"
export HELM_HOME="$XDG_CONFIG_HOME/helm"
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql/history"
export MYVIMRC="$XDG_CONFIG_HOME/nvim/init.vim"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_DEVDIR="$XDG_DATA_HOME/node/gyp" # node-gyp
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf" # pip incorrectly assumes mac doesn't want XDG_CONFIG_HOME.
export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/history"
export TERMINFO="$XDG_CONFIG_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export TERMINUS_PLUGINS_DIR="$XDG_DATA_HOME/terminus/plugins"
export TERMINUS_CACHE_DIR="$XDG_CACHE_HOME/terminus"
export TIGRC_USER="$XDG_CONFIG_HOME/tig/tigrc"
export TMUX_PLUGIN_MANAGER_PATH="$XDG_CONFIG_HOME/tmux/plugins"
export VAGRANT_DOTFILE_PATH="$XDG_DATA_HOME/vagrant"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export VIMINIT="source $MYVIMRC"
export XAUTHORITY="$XDG_DATA_HOME/Xauthority"

# Aliases Respecting Programs
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

export TZ=:/etc/localtime
export TMPDIR=$XDG_CACHE_HOME

export SCOUT_DISABLE=1

# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--reverse --inline-info"
