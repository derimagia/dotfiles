
if (( $+commands[fasd] )); then
    __fzfcmd() {
      [ ${FZF_TMUX:-1} -eq 1 ] && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
    }

    fzf-history-widget() {
      local selected num
      selected=( $(fc -l 1 | $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r ${=FZF_CTRL_R_OPTS} -q "${LBUFFER//$/\\$}") )
      if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
          zle vi-fetch-history -n $num
        fi
      fi
      zle redisplay
    }

    _fzf_compgen_path() {
      ag -g "" "$1"
    }

    _fzf_compgen_dir() {
        find -L "$1" \
          -name .git -prune -o -name .svn -prune -o -type d \
          -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
    }

    zle -N fzf-history-widget
    bindkey '^R' fzf-history-widget

    fasd_cache="$DOTFILES_CACHE_DIR/fasd-init.sh"

    if [ $commands[fasd] -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
    fi

    source "$fasd_cache"
    unset fasd_cache
fi
