if [[ $OSTYPE =~ darwin && -x /usr/libexec/path_helper ]]; then
	if [[ ! -f "$TMPPREFIX"/path-helper.sh ]]; then
		ink -c green -- '- Generating Path Helper Bundle -'
		/usr/libexec/path_helper -s > "$TMPPREFIX"/path-helper.sh
	fi
	source  "$TMPPREFIX"/path-helper.sh
fi

export PAGER='bat -p'
export BAT_PAGER='less -FXR'
export EDITOR='nvim'
export VISUAL='subl'

# Defaults
: ${LANG:='en_US.UTF-8'}

{
	setopt LOCAL_OPTIONS EXTENDED_GLOB
	autoload -Uz zrecompile

	zrecompile -qp -- \
		"$ZDOTDIR"/.zcompdump -- \
		"$ZDOTDIR"/.zshrc -- \
		"$ZDOTDIR"/autoload/prompt_pure_setup

	zrecompile -qp "$ZDOTDIR"/autoload.zwc "$ZDOTDIR"/autoload/^(_*|prompt_*_setup|*.*)(-.N)

	rm -f "$ZDOTDIR"/.zcompdump.zwc.old "$ZDOTDIR"/.zshrc.zwc.old "$ZDOTDIR"/autoload/prompt_pure_setup.zwc.old "$ZDOTDIR"/autoload.zwc.old

	for file ("$ZDOTDIR"/*.plugin.zsh) {
	  zrecompile -qp "$file"
	  rm -f  "$file".zwc.old
	}
}&!

