#!/usr/bin/env zsh

# Async
[[ -f $ZPLUG_REPOS/mafredri/zsh-async/async.plugin.zsh ]] && source $ZPLUG_REPOS/mafredri/zsh-async/async.plugin.zsh

# PLATFORM
export SHELL_PLATFORM='unknown'
ostype() { echo "$OSTYPE" | tr '[:upper:]' '[:lower:]'; }

case "$(ostype)" in
    *'linux'*) SHELL_PLATFORM='linux' ;;
    *'darwin'*) SHELL_PLATFORM='osx' ;;
esac

is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }

is_osx() { [[ $SHELL_PLATFORM == 'osx' ]]; }

# General functions that should be loaded first

# Has Commands
has.{command,function,builtin,alias,galias}() {
    eval "(( $+${0/#has./}s[${1:?too few argument}] ))"
    return $status
}

has() {
    has.function "$1" ||  \
    has.command "$1" ||  \
    has.builtin "$1" ||  \
    has.alias "$1" ||  \
    has.galias "$1"

    return $status
}

is_login_shell() { [[ $SHLVL == 1 ]]; }

is_interactive_shell() { [ ! -z "$PS1" ]; }

is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

hasnt() { (! has "$1") }

# Autoload vitals
autoload -Uz add-zsh-hook
