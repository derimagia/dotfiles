#!/usr/bin/env zsh
setopt prompt_subst
setopt transient_rprompt



r-prompt() {
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

autoload -U add-zsh-hook
add-zsh-hook precmd r-prompt
