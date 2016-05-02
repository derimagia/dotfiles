setopt transient_rprompt

_rprompt() {
    last_status=$?

    __drush_ps1() {
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

      [[ -n "$__DRUPAL_SITE" ]] && printf "(%s)" "${ENV_COLOR}${__DRUPAL_SITE}%{$reset_color%}"
    }

    _status() {
        local LAST_STATUS_TRUE='✔'
        local LAST_STATUS_FALSE='✘'

        if [[ $last_status = 0 ]]; then
            printf "%s" "%{$fg[yellow]%}$LAST_STATUS_TRUE%{$reset_color%}"
        else
            printf "%s" "%{$fg[red]%}$LAST_STATUS_FALSE%{$reset_color%}"
        fi
    }

    RPROMPT="$(__drush_ps1) $(_status)"
}

add-zsh-hook precmd _rprompt