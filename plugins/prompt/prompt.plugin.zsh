setopt transient_rprompt

_rprompt() {
    local last_status=$?
    local local_drush_prompt
    local last_status_prompt

    _drush_rprompt() {
        local f="${TMPDIR:-/tmp/}/drush-env-${USER}/drush-drupal-site-$$"

        if [[ -f $f ]]; then
            DRUSH_SITE=$(< $f)
        else
            DRUSH_SITE="$DRUPAL_SITE"
        fi

        case "$DRUSH_SITE" in
            *.live|*.prod) local ENV_COLOR="%{$fg[red]%}" ;;
            *.stage|*.test) local ENV_COLOR="%{$fg[yellow]%}" ;;
            *.local) local ENV_COLOR="%{$fg[green]%}" ;;
            *) local ENV_COLOR="%{$fg[blue]%}" ;;
        esac

        [[ -n "$DRUSH_SITE" ]] && local_drush_prompt="${ENV_COLOR}${DRUSH_SITE}%{$reset_color%}"
    }

    _last_status_rprompt() {
        if [[ $last_status = 0 ]]; then
            last_status_prompt="%{$fg[green]%}✔%{$reset_color%}"
        else
            last_status_prompt="%{$fg[red]%}✘%{$reset_color%}"
        fi
    }

    _drush_rprompt
    _last_status_rprompt

    if is_tmux_runnning; then
        tmux_pane=$(tmux display -p "#D" | tr -d %)

        _send_to_tmux() {
            tmux setenv -g "TMUX_$1_${tmux_pane}" "$2"
        }

        _send_to_tmux DRUSH_SITE $DRUSH_SITE
        _send_to_tmux TERMINUS_SITE $TERMINUS_SITE
        _send_to_tmux TERMINUS_ENV $TERMINUS_ENV

        tmux refresh-client -S
    fi

    RPROMPT="$local_drush_prompt $last_status_prompt"
}

add-zsh-hook precmd _rprompt
