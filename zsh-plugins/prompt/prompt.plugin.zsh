setopt transient_rprompt

_status() {
  local LAST_STATUS_TRUE='✔'
  local LAST_STATUS_FALSE='✘'
  RETVAL=$?
    if [ $RETVAL -eq 0 ]; then
        if [[ $COLORS == "true" ]]; then
            export last_status="%{$fg[yellow]%}$LAST_STATUS_TRUE%{$reset_color%}"
        else
            export last_status="$LAST_STATUS_TRUE"
        fi
    else
        if [ $RETVAL -ne 0 ]; then
        if [[ $COLORS == "true" ]]; then
            export last_status="%{$fg[red]%}$LAST_STATUS_FALSE%{$reset_color%}"
        else
            export last_status="$LAST_STATUS_FALSE"
        fi
      fi
    fi
}

_rprompt() {
      local COLOR_BLUE='%F{blue}'
      local COLOR_CYAN='%F{cyan}'
      local COLOR_GREEN='%F{green}'
      local COLOR_MAGENTA='%F{magenta}'
      local COLOR_RED='%F{red}'
      local COLOR_WHITE='%F{white}'
      local COLOR_YELLOW='%F{yellow}'
      local COLOR_NONE='%f'

    __drush_ps1() {
      f="${TMPDIR:-/tmp/}/drush-env-${USER}/drush-drupal-site-$$"
      if [ -f $f ]
      then
        __DRUPAL_SITE=$(cat "$f")
      else
        __DRUPAL_SITE="$DRUPAL_SITE"
      fi
      case "$__DRUPAL_SITE" in
        *.live|*.prod) local ENV_COLOR="$COLOR_RED" ;;
        *.stage|*.test) local ENV_COLOR="$COLOR_YELLOW" ;;
        *.local) local ENV_COLOR="$COLOR_GREEN" ;;
        *) local ENV_COLOR="$COLOR_BLUE" ;;
      esac

      [[ -n "$__DRUPAL_SITE" ]] && printf "(%s)" "${ENV_COLOR}${__DRUPAL_SITE}${COLOR_NONE}"
    }
    RPROMPT=$(__drush_ps1)
}

add-zsh-hook precmd _status
add-zsh-hook precmd _rprompt