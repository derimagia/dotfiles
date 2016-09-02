#!/usr/bin/env zsh

# Async
$(antibody bundle mafredri/zsh-async)

# General functions that should be loaded first
is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
is_macos() { [[ $SHELL_PLATFORM == 'macos' ]]; }
is_login_shell() { [[ $SHLVL == 1 ]]; }
is_interactive_shell() { [ ! -z "$PS1" ]; }
is_ssh_running() { [ ! -z "$SSH_CONNECTION" ]; }
