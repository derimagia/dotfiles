setopt transient_rprompt

_rprompt() {
    local last_status=$?
    local local_drush_prompt

    _drush_rprompt() {
        local f="${TMPDIR:-/tmp/}/drush-env-${USER}/drush-drupal-site-$$"

        if [[ -f $f ]]; then
            DRUSH_SITE=$(< $f)
        else
            DRUSH_SITE="$DRUPAL_SITE"
        fi

        case "$DRUSH_SITE" in
            *.live|*.prod) local ENV_COLOR="%{$FG[red]%}" ;;
            *.stage|*.test) local ENV_COLOR="%{$FG[yellow]%}" ;;
            *.local) local ENV_COLOR="%{$FG[green]%}" ;;
            *) local ENV_COLOR="%{$FG[blue]%}" ;;
        esac

        [[ -n "$DRUSH_SITE" ]] && local_drush_prompt="${ENV_COLOR}${DRUSH_SITE}%{${FX[reset]}%}"
    }

    _drush_rprompt

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

    RPROMPT="$local_drush_prompt"
}

add-zsh-hook precmd _rprompt
