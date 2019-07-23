export TZ=:/etc/localtime

# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME"/.config}

if [[ $OSTYPE =~ darwin ]]; then
	export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME"/Library/Caches}
	export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME"/Library}
else
	export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME"/.cache}
	export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME"/.local/share}
fi

export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME"/ansible/ansible.cfg
export AZURE_CONFIG_DIR="$XDG_CONFIG_HOME"/azure
export BABEL_CACHE_PATH="$XDG_CACHE_HOME"/node/babel.cache.json
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export COMPOSER_HOME="$XDG_DATA_HOME"/composer
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export GRADLE_USER_HOME="$XDG_CACHE_HOME"/gradle
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export HELM_HOME="$XDG_CONFIG_HOME"/helm
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PEX_ROOT="$XDG_CACHE_HOME"/pex # Used for telepresence
export RANDFILE="$XDG_CACHE_HOME"/rnd
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/history

# Set up TMPPREFIX
TMPPREFIX="$XDG_CACHE_HOME"/zsh

typeset -U path
export -TU GOPATH gopath=("$HOME"/go)
export -TU KUBECONFIG kubeconfig=("$XDG_CONFIG_HOME"/kube/config.yaml "$XDG_CONFIG_HOME"/kube/*.yaml(N))

# Make sure some directories exist
mkdir -p "$XDG_DATA_HOME"/node "$XDG_DATA_HOME"/zsh "$XDG_CACHE_HOME"/less "$TMPPREFIX"

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprofile"
fi
