(( $+commands[fasd] )) || return

if [[ ! -s $TMPPREFIX/fasd-init.sh ]]; then
    fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $TMPPREFIX/fasd-init.sh
fi

source $TMPPREFIX/fasd-init.sh
