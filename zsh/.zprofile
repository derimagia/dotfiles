export EDITOR='nvim'
export VISUAL="$EDITOR"

if [[ -n "$DISPLAY" || "$TERM_PROGRAM" = 'Apple_Terminal' ]]; then
    export VISUAL='subl --wait --launch-or-new-window'
fi

if (( $+commands[bat] )); then
	export PAGER='bat -p'
	export BAT_PAGER='less -FXR'
fi
