[[ $TERM != dumb ]] || return

autoload -Uz colors && colors

if (( $+commands[grc] )); then
    alias cl='grc -es --colour=auto'
    alias configure='cl ./configure'
    alias make='cl make'
    alias gcc='cl gcc'
    alias g++='cl g++'
    alias as='cl as'
    alias php'cl php'
    alias dig='cl dig'
    alias mount='cl mount'
    alias ld='cl ld'
    alias ping='cl ping'
    alias traceroute='cl traceroute'
    alias docker='cl docker'
    alias docker-compose='cl docker-compose'
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

zle_highlight+=(
    default:none
    region:standout
    special:standout
    suffix:bold
    isearch:underline
    paste:underline
)

## ZSH Highlight
typeset -gA FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[alias]='fg=blue'
FAST_HIGHLIGHT_STYLES[builtin]='fg=blue'
FAST_HIGHLIGHT_STYLES[function]='fg=blue'
FAST_HIGHLIGHT_STYLES[command]='fg=blue'
FAST_HIGHLIGHT_STYLES[precommand]='fg=cyan,underline'
FAST_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
FAST_HIGHLIGHT_STYLES[path]='fg=magenta'
FAST_HIGHLIGHT_STYLES[path_pathseparator]='fg=magenta,bold'
FAST_HIGHLIGHT_STYLES[path_prefix]='fg=magenta,underline'
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
FAST_HIGHLIGHT_STYLES[comment]='fg=green,bold'

if [[ ! -s $TMPPREFIX/dircolors-init.sh ]]; then
    dircolors -b $XDG_CONFIG_HOME/ls/LS_COLORS >| $TMPPREFIX/dircolors-init.sh
fi

source $TMPPREFIX/dircolors-init.sh
