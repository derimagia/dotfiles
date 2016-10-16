if (( $+commands[fzf] )); then
    export FZF_DEFAULT_OPTS="--inline-info"

    __fzfcmd() {
      [ ${FZF_TMUX:-1} -eq 1 ] && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
    }

    _fzf_compgen_path() {
      ag -g "" "$1"
    }

    _fzf_compgen_dir() {
        find -L "$1" \
          -name .git -prune -o -name .svn -prune -o -type d \
          -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
    }
fi

if (( $+commands[fasd] )); then
    if [[ ! -s $TMPPREFIX/fasd-init.sh ]]; then
        fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $TMPPREFIX/fasd-init.sh
    fi

    source $TMPPREFIX/fasd-init.sh
fi
