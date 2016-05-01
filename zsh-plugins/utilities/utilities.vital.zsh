#!/usr/bin/env zsh

# General functions that should be loaded first

# Has Commands
has.{command,function,builtin,alias,galias}() {
    eval "(( $+${0/#has./}s[${1:?too few argument}] ))"
    return $status
}

has() {
    has.function "$1" || \
        has.command "$1" || \
        has.builtin "$1" || \
        has.alias "$1" || \
        has.galias "$1"

    return $status
}

# Global Aliases
alias -g __DIRECTORY__='${${(%):-%N}:A:h}' # Get Directory Script is in

require() { echo $(readlink -f $0) }
is_login_shell() { [[ $SHLVL == 1 ]]; }
shell_has_started_interactively() { [ ! -z "$PS1" ]; }
is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
hasnt() { ( ! has "$1" ) }
is_git_repo() { git rev-parse --is-inside-work-tree &>/dev/null; }

# PLATFORM
export SHELL_PLATFORM='unknown'
ostype() { echo "$OSTYPE" | tr '[:upper:]' '[:lower:]'; }
case "$(ostype)" in
    *'linux'*)  SHELL_PLATFORM='linux' ;;
    *'darwin'*) SHELL_PLATFORM='osx'   ;;
esac
is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
is_osx()   { [[ $SHELL_PLATFORM == 'osx' ]]; }

allcolors() {
    # credit to http://askubuntu.com/a/279014
    for x in 0 1 4 5 7 8; do
        for i in `seq 30 37`; do
            for a in `seq 40 47`; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
    echo ""
}

# Autoload vitals
autoload -Uz add-zsh-hook