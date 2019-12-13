# Setup Prompt
typeset -ga prompt_pure_extras=()
autoload -Uz prompt_pure_setup
prompt_pure_setup

# autoload -Uz bracketed-paste-url-magic url-quote-magic
# bracketed-paste-url-magic is a simplier version of bracketed-paste-magic
# autoload -Uz bracketed-paste-url-magic url-quote-magic
# zle -N bracketed-paste bracketed-paste-url-magic
# zle -N self-insert url-quote-magic
