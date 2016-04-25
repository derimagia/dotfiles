# tmux
alias tmux='tmux -2'
alias ta='tmux attach -d'
alias tnew='tmux new -s'
alias tmn='tmux -CC new -As $(basename $(pwd))'

# Start TMUXX by calling tmuxx
_start-tmux-if-it-is-not-already-started() {
    BUFFER=tmuxx
    CURSOR=$#BUFFER
    zle accept-line
}
zle -N _start-tmux-if-it-is-not-already-started
bindkey '^T' _start-tmux-if-it-is-not-already-started

is_screen_running() { [ ! -z "$STY" ]; }
is_tmux_runnning() { [ ! -z "$TMUX" ]; }
is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }

fpath+="`dirname $0`/functions"
autoload tmuxx