is_screen_running() { [ ! -z "$STY" ]; }
is_tmux_runnning() { [ ! -z "$TMUX" ]; }
is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
