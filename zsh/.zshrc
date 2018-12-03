(( $PROFILING )) && zmodload zsh/zprof

: ${TERM:=xterm-256color}

# Set up TMPPREFIX
TMPPREFIX="$XDG_CACHE_HOME"/zsh
mkdir -p "$TMPPREFIX"

# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
setopt \
	MULTIOS AUTO_CD \
	INTERACTIVE_COMMENTS MAGIC_EQUAL_SUBST SHORT_LOOPS \
	EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_IGNORE_DUPS \
	KSH_OPTION_PRINT

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv

# Reset key bindings
bindkey -e

# ZSH ENV Variables
HISTFILE="$XDG_DATA_HOME/zsh/history" HISTSIZE=100000 SAVEHIST=100000

## Custom Packages

# Autoload files
autoload -Uz "$ZDOTDIR"/autoload/*(-.N:t)
fpath+=("$ZDOTDIR"/autoload)
path=("$ZDOTDIR"/bin $path)

for plugin_file ("$ZDOTDIR"/*.plugin.zsh) source $plugin_file
unset plugin_file

## Packages
if [[ ! -f "$TMPPREFIX/antibody-plugins.sh" ]] {
	ink -c green -- '- Generating Antibody Bundle -'

	{
		# Packaged
		local antibody_plugins=(
			zsh-users/zsh-completions
			zsh-users/zsh-history-substring-search
			psprint/history-search-multi-word
			zsh-users/zsh-autosuggestions
			zdharma/fast-syntax-highlighting
		)

		antibody init
		echo ${(F)antibody_plugins} | antibody bundle
	} | > "$TMPPREFIX/antibody-plugins.sh"
}
source "$TMPPREFIX/antibody-plugins.sh"

(( $+gopath )) && path+=(${^gopath}/bin)
(( $+CARGO_HOME )) && path+=("$CARGO_HOME"/bin)
(( $+COMPOSER_HOME )) && path+=("$COMPOSER_HOME"/vendor/bin)

bindkey '^[[A' history-substring-search-up # Sourcing after syntax-highlighting
bindkey '^[[B' history-substring-search-down

## Local
path=("$ZDOTDIR"/local/bin $path)
[[ -f "$ZDOTDIR"/.zlocalrc ]] && source "$ZDOTDIR"/.zlocalrc

compinit -C

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

(( $PROFILING )) && zprof
