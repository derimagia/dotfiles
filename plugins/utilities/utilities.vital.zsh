#!/usr/bin/env zsh

# Async
[[ -f $ZPLUG_REPOS/mafredri/zsh-async/async.plugin.zsh ]] && source $ZPLUG_REPOS/mafredri/zsh-async/async.plugin.zsh

# General functions that should be loaded first
is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
is_osx() { [[ $SHELL_PLATFORM == 'osx' ]]; }
is_login_shell() { [[ $SHLVL == 1 ]]; }
is_interactive_shell() { [ ! -z "$PS1" ]; }
is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
