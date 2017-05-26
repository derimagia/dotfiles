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

_pprompt_node() {
    (( $+functions[nvm] )) || return

    async_start_worker node_version 2>/dev/null && {
        async_register_callback node_version _detect_node_version_callback
        async_job node_version node --version

        _detect_node_version_callback() {
            node_version=$3
            async_stop_worker node_version
        }
    }

    [[ -f package.json ]] || return

    [[ -n $node_version ]] && _pprompt_section 'green' "⬢  $node_version"
}

_pprompt_docker() {
    async_start_worker docker_version 2>/dev/null && {
        async_register_callback docker_version _detect_docker_version_callback
        async_job docker_version docker version -f "{{.Server.Version}}"

        _detect_docker_version_callback() {
            docker_errcode=$2
            docker_version=$3
            async_stop_worker docker_version
        }
    }

    [[ -f Dockerfile || -f docker-compose.yml || -f docker-compose.yaml ]] || return

    (( $docker_errcode )) || _pprompt_section '' "🐳"
}

_pprompt_precmd() {
    prompt_pure_extras=()
    _pprompt_precmd_drush

    [[ -n "$DESK_NAME" ]] && prompt_pure_extras+=("%F{cyan}${DESK_NAME}%f")
}

# Setup Prompt
promptinit && prompt pure
add-zsh-hook precmd _pprompt_precmd

autoload -Uz bracketed-paste-url-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-url-magic
zle -N self-insert url-quote-magic


