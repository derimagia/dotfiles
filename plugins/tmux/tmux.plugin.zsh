# tmux
alias tmux='tmux -2'
alias ta='tmux attach -d'
alias tnew='tmux new -s'

if ! is_tmux_runnning && (( $+commands[tmux] )); then
    tmuxx
fi


if [[ ! -d ~/.tmux/plugins/tpm/ ]]; then
    echo "Installing tpm."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
fi

#if (( $+commands[tmuxp] )); then
#    eval "$(_TMUXP_COMPLETE=source tmuxp)"
#fi
