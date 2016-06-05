# Setting Terminal
if [[ -n "$TMUX"  ]]; then
    export TERM=screen-256color
else
    export TERM=xterm-256color
fi

# General Terminal Options
setopt COMPLETE_ALIASES MULTIOS PUSHD_TO_HOME AUTOCD EXTENDED_GLOB RC_EXPAND_PARAM BEEP INTERACTIVECOMMENTS
setopt MENU_COMPLETE # Automatically select menu

bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down


# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
setopt HISTIGNORESPACE EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_DUPS
setopt KSHOPTIONPRINT # Better Options with setopt

DISABLE_UNTRACKED_FILES_DIRTY=true

# F5 to reload zsh
_zle_re() {
    re
    zle accept-line
}
zle -N _zle_re
bindkey $terminfo[kf5] _zle_re

# Load Fasd
(( $+commands[fasd] )) && eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
