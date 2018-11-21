export TZ=:/etc/localtime

# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

if [[ $OSTYPE =~ darwin ]]; then
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/Library/Caches"}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/Library"}
else
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
fi

(( $+commands[ansible] )) && export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
(( $+commands[rust] )) && export CARGO_HOME="$XDG_DATA_HOME/cargo"
(( $+commands[composer] )) && export COMPOSER_HOME="$XDG_DATA_HOME/composer"
(( $+commands[gradle] )) && export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"
(( $+commands[npm] )) && export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
(( $+commands[go] )) && typeset -TUx GOPATH gopath; gopath=($HOME/go)

# history files
(( $+commands[node] )) && export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"
(( $+commands[redis] )) && export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/history"

# Kubectl
(( $+commands[kubectl] )) && () {
    local -U kubeconfigs=("$HOME/.kube/config" "$XDG_CONFIG_HOME"/kube/*.yaml(N))
    export KUBECONFIG="${(j;:;)kubeconfigs}"
}

