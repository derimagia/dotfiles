#!/usr/bin/env zsh

(( $+commands[tmux] )) || exit 34

ink -c green "Installing tpm."
[[ -d $TMUX_PLUGIN_MANAGER_PATH/tpm ]] || git clone https://github.com/tmux-plugins/tpm $TMUX_PLUGIN_MANAGER_PATH/tpm

tmux new -s tmux '$TMUX_HOME/plugins/tpm/bin/install_plugins && exit' >/dev/null

