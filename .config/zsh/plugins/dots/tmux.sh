#!/usr/bin/env zsh

(( $+commands[tmux] )) || exit 34

ink -c green "Installing tpm."
git clone https://github.com/tmux-plugins/tpm $TMUX_HOME/plugins/tpm
# $TMUX_HOME/plugins/tpm/bin/install_plugins
