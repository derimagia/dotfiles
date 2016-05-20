setopt transient_rprompt

_rprompt() {
    last_status=$?

    if [[ $last_status = 0 ]]; then
        last_status_prompt="%{$fg[yellow]%}✔%{$reset_color%}"
    else
        last_status_prompt="%{$fg[red]%}✘%{$reset_color%}"
    fi

    f="${TMPDIR:-/tmp/}/drush-env-${USER}/drush-drupal-site-$$"
    if [ -f $f ]
    then
        __DRUPAL_SITE=$(cat "$f")
    else
        __DRUPAL_SITE="$DRUPAL_SITE"
    fi
    case "$__DRUPAL_SITE" in
        *.live|*.prod) local ENV_COLOR="%{$fg[red]%}" ;;
        *.stage|*.test) local ENV_COLOR="%{$fg[yellow]%}" ;;
        *.local) local ENV_COLOR="%{$fg[green]%}" ;;
        *) local ENV_COLOR="%{$fg[blue]%}" ;;
    esac

    [[ -n "$__DRUPAL_SITE" ]] && local_drush_prompt="${ENV_COLOR}${__DRUPAL_SITE}%{$reset_color%}"

    RPROMPT="$local_drush_prompt $last_status_prompt"
}

add-zsh-hook precmd _rprompt