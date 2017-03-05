(( $+commands[fasd] )) || return

[[ -d $XDG_DATA_HOME/fasd ]] || mkdir -p $XDG_DATA_HOME/fasd
export _FASD_DATA=$XDG_DATA_HOME/fasd/fasd

if [[ ! -s $TMPPREFIX/fasd-init.sh ]]; then
    fasd --init \
        zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $TMPPREFIX/fasd-init.sh
fi

source $TMPPREFIX/fasd-init.sh
