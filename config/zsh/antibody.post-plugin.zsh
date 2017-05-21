if [[ ! -f $TMPPREFIX/antibody-plugins.sh ]]; then
    antibody bundle > $TMPPREFIX/antibody-plugins.sh <<-PLUGINS
sindresorhus/pure
zsh-users/zsh-history-substring-search
psprint/history-search-multi-word
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
PLUGINS
fi

source $TMPPREFIX/antibody-plugins.sh

# This needs to run after sourcing syntax-highlighting.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
