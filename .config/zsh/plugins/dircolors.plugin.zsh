(( $+commands[dircolors] )) || return

if [[ ! -s $TMPPREFIX/dircolors-init.sh ]]; then
    dircolors -b $XDG_CONFIG_HOME/ls/LS_COLORS >| $TMPPREFIX/dircolors-init.sh
fi

source $TMPPREFIX/dircolors-init.sh
