(( $PROFILING )) && zmodload zsh/zprof

# export TZ=:/etc/localtime

# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}

if [[ $OSTYPE =~ darwin ]]; then
	export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/Library/Caches}
	export XDG_DATA_HOME=${XDG_DATA_HOME:-~/Library}
else
	export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
	export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
fi

# XDG Fixes
export ANDROID_HOME="$XDG_CONFIG_HOME"/android
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME"/ansible/ansible.cfg
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AZURE_CONFIG_DIR="$XDG_CONFIG_HOME"/azure
export BABEL_CACHE_PATH="$XDG_CACHE_HOME"/node/babel.cache.json
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
# export COMPOSER_HOME="$XDG_DATA_HOME"/composer
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export -TU KUBECONFIG kubeconfig=("$XDG_CONFIG_HOME"/kube/config.yaml "$XDG_CONFIG_HOME"/kube/*.yaml(N))
export KDEHOME="$XDG_CONFIG_HOME"/kde
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GRADLE_USER_HOME="$XDG_CACHE_HOME"/gradle
# export JAVA_TOOL_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
# export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
# export HELM_HOME="$XDG_CONFIG_HOME"/helm
# export IDEA_PROPERTIES="$XDG_CONFIG_HOME"/intellij-idea/idea.properties
# export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME"/intellij-idea/idea.vmoptions
# export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
# export JUPYTERLAB_DIR="$XDG_DATA_HOME"/jupyter/lab
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export RANDFILE="$XDG_CACHE_HOME"/rnd
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/history
export VSCODE_EXTENSIONS="$XDG_DATA_HOME"/code-oss/extensions
export WGETRC="$XDG_CONFIG_HOME"/wgetrc
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv/ComputeCache
[[ -d $CUDA_CACHE_PATH ]] || mkdir -p $CUDA_CACHE_PATH

# if [[ -d "$XDG_RUNTIME_DIR" ]]; then
#	export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
# fi

# Set up paths
# typeset -U path

export -TU GOPATH gopath=(~/go)
path+=(${^gopath}/bin)

export GDK_CORE_DEVICE_EVENTS=1 # Mouse scrolling fix - https://github.com/sublimehq/sublime_text/issues/2512
# export QT_LOGGING_RULES='*.debug=false;qt.qpa.*=false'
export GTK_USE_PORTAL=1

(( $+CARGO_HOME )) && path+=("$CARGO_HOME"/bin)
(( $+COMPOSER_HOME )) && path+=("$COMPOSER_HOME"/vendor/bin)
# (( $+ANDROID_SDK_ROOT )) && path+=("$ANDROID_SDK_ROOT"/platform-tools)

# Set up TMPPREFIX
TMPPREFIX="$XDG_CACHE_HOME"/zsh

# Make sure some directories exist
mkdir -p "$XDG_DATA_HOME"/node "$XDG_CACHE_HOME"/less "$TMPPREFIX"
