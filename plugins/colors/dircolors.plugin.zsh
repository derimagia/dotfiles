(( $+commands[dircolors] )) || return

if [[ ! -s $TMPPREFIX/dircolors-init.sh ]]; then
    dircolors -b $DOTFILES/plugins/colors/LS_COLORS >| $TMPPREFIX/dircolors-init.sh
fi

source $TMPPREFIX/dircolors-init.sh
