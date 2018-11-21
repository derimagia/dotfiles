# Setup Prompt
typeset -ga prompt_pure_extras=()
autoload -Uz prompt_pure_setup bracketed-paste-url-magic url-quote-magic
prompt_pure_setup

# bracketed-paste-url-magic is a simplier version of bracketed-paste-magic
autoload -Uz bracketed-paste-url-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-url-magic
zle -N self-insert url-quote-magic

# zsh-sticky-prefix
local zle_sticked
zle-line-init() {
    BUFFER="$zle_sticked$BUFFER"
    zle end-of-line
}
zle -N zle-line-init

zle-set-sticky() {
    zle_sticked="$BUFFER"
    zle -M "Sticky: '$zle_sticked'"
}
zle -N zle-set-sticky

accept-line() {
    if [[ -z "$BUFFER" ]] && [[ -n "$zle_sticked" ]]; then
        zle_sticked=
    fi
    zle .accept-line
}
zle -N accept-line

bindkey '^>' expand-all-aliases
bindkey '^ ' zle-set-sticky
