if [[ ! -f $TMPPREFIX/antibody-plugins.sh ]]; then
    antibody bundle > $TMPPREFIX/antibody-plugins.sh <<-PLUGINS
sindresorhus/pure
tarrasch/zsh-bd
zsh-users/zsh-completions
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

(( $+functions[prompt_pure_preexec] )) && zle -N clear-screen prompt_pure_clear_screen
