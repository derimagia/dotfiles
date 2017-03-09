# See https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

if [[ $OSTYPE =~ darwin ]]; then
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/Library/Caches}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/Library}
else
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
fi

export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"
export ADB_VENDOR_KEYS="$ANDROID_SDK_HOME/.android"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_CREDENTIAL_FILE="$XDG_CONFIG_HOME/aws/credentials"
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME/composer"
export DESK_DESKS_DIR="$XDG_DATA_HOME/desks"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem/specs"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PSQLRC="$XDG_CONFIG_HOME/psql/psqlrc"
export PSQL_HISTORY="$XDG_DATA_HOME/psql/history"
export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/history"
export TERMINFO="$XDG_CONFIG_HOME/terminfo"
export TERMINUS_PLUGINS_DIR="$XDG_DATA_HOME/terminus/plugins"
export TERMINUS_CACHE_DIR="$XDG_CACHE_HOME/terminus"
export TMUX_HOME="$XDG_CONFIG_HOME/tmux"
export TMUX_PLUGIN_MANAGER_PATH="$TMUX_HOME/plugins"
export TPM_PATH="$TMUX_HOME/plugins"
export VAGRANT_DOTFILE_PATH="$XDG_DATA_HOME/vagrant"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export VIMINIT="source $XDG_CONFIG_HOME/nvim/init.vim"
export VIMPAGER_RC="$XDG_CONFIG_HOME/nvim/init.vim"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Aliases Respecting Programs
alias tmux="tmux -f $TMUX_HOME/tmux.conf"

export TZ=:/etc/localtime
export DOTFILES=$HOME/.dotfiles
export TMPDIR=$XDG_CACHE_HOME

# export LOCATE_PATH=/var/db/locate.database
export PROJECTS_DIR=$HOME/projects

