if [[ -z "$TERM" ]]; then
    export TERM=xterm-256color
fi

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

DISABLE_UNTRACKED_FILES_DIRTY=true

# F5 to reload zsh
_zle_re() {
    re
    zle accept-line
}
zle -N _zle_re
bindkey $terminfo[kf5] _zle_re

# bracketed-paste-url-magic is a simplier version of bracketed-paste-magic
autoload -Uz bracketed-paste-url-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-url-magic
zle -N self-insert url-quote-magic

# Hook for desk activation
if [[ -n "$DESK_ENV" ]]; then
    source "$DESK_ENV"
    if [[ -z $DESK_INIT ]]; then
        # @TODO Make this only happen once, is there a better way to do this?
        export DESK_INIT=1
        [[ -n $PROJECT_PATH ]] && cd $PROJECT_PATH
        [[ -n $DRUSH_ALIAS ]] && drush site-set $DRUSH_ALIAS # Faster way to do this?ss
    fi
fi
