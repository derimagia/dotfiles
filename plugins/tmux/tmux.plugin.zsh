# tmux
alias tmux='tmux -2'
alias ta='tmux attach -d'
alias tnew='tmux new -s'

if [[ ! -d ~/.tmux/plugins/tpm/ ]]; then
    echo "Installing tpm."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
fi
