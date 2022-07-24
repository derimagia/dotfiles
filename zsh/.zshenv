(( ${+ZPROFILING} )) && zmodload zsh/zprof

# export TZ=:/etc/localtime

# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}

if [[ $OSTYPE == darwin* ]]; then
	export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/Library/Caches}
	export XDG_DATA_HOME=${XDG_DATA_HOME:-~/Library}
else
	export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
	export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
fi

# XDG Fixes
export ANDROID_HOME="$XDG_CONFIG_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv/ComputeCache
# [[ -d $CUDA_CACHE_PATH ]] || mkdir -p $CUDA_CACHE_PATH
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GRADLE_USER_HOME="$XDG_CACHE_HOME"/gradle
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSHISTFILE=-
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export RANDFILE="$XDG_CACHE_HOME"/rnd
export VSCODE_EXTENSIONS="$XDG_DATA_HOME"/code-oss/extensions
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export YOURKIT_HOME="$XDG_DATA_HOME"/yjp

# if [[ -d "$XDG_RUNTIME_DIR" ]]; then
#	export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
# fi

export GDK_CORE_DEVICE_EVENTS=1 # Mouse scrolling fix - https://github.com/sublimehq/sublime_text/issues/2512
# export QT_LOGGING_RULES='*.debug=false;qt.qpa.*=false'
export GTK_USE_PORTAL=1

export -TU GOPATH gopath=(~/go)
path+=(${^gopath}/bin)

(( $+CARGO_HOME )) && path+=("$CARGO_HOME"/bin)
# (( $+ANDROID_SDK_ROOT )) && path+=("$ANDROID_SDK_ROOT"/platform-tools)

# Make sure some directories exist
mkdir -p "$XDG_DATA_HOME"/node "$XDG_CACHE_HOME"/less "$TMPPREFIX"
