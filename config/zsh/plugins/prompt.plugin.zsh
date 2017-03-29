add-zsh-hook precmd _rprompt

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
