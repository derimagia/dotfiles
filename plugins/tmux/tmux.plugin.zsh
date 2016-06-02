# tmux
alias tmux='tmux -2'
alias ta='tmux attach -d'
alias tnew='tmux new -s'

 if ! is_tmux_runnning && (( $+commands[tmux] )); then
    tmuxx
 fi
