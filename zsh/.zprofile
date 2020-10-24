export EDITOR='nvim'
export VISUAL='subl --wait'

if (( $+commands[bat] )); then
	export PAGER='bat -p'
	export BAT_PAGER='less -FXR'
fi

# Defaults
{
	setopt LOCAL_OPTIONS EXTENDED_GLOB
	autoload -Uz zrecompile

	zrecompile -qp -- \
		"$ZDOTDIR"/.zcompdump -- \
		"$ZDOTDIR"/autoload/prompt_pure_setup

	zrecompile -qp "$ZDOTDIR"/autoload.zwc "$ZDOTDIR"/autoload/^(_*|prompt_*_setup|*.*)(-.N)

	rm -f "$ZDOTDIR"/**/{*,.*}.zwc.old(N)
}&!
