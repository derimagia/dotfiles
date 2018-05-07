_pprompt_precmd_drush() {
    local f="${TMPDIR:-/tmp/}/drush-env-$USER/drush-drupal-site-$$"
    local ENV_COLOR

    if [[ -f $f ]]; then
        DRUSH_SITE=$(< $f)
    else
        DRUSH_SITE="$DRUPAL_SITE"
    fi

    case "$DRUSH_SITE" in
        *.live|*.prod) ENV_COLOR='red' ;;
        *.stage|*.test) ENV_COLOR="yellow" ;;
        *.local|*.dev) ENV_COLOR="green" ;;
        *) ENV_COLOR="blue" ;;
    esac

    [[ -n "$DRUSH_SITE" ]] && prompt_pure_extras+=("%F{$ENV_COLOR}${DRUSH_SITE}%f")
}

_pprompt_precmd() {
    prompt_pure_extras=()
    _pprompt_precmd_drush
    # [[ -n "$DESK_NAME" ]] && prompt_pure_extras+=("%F{cyan}${DESK_NAME}%f")
}

# Setup Prompt
promptinit && prompt pure
add-zsh-hook precmd _pprompt_precmd

# bracketed-paste-url-magic is a simplier version of bracketed-paste-magic
autoload -Uz bracketed-paste-url-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-url-magic
zle -N self-insert url-quote-magic
