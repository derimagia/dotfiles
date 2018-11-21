[[ $TERM != dumb ]] || return

autoload -Uz colors && colors

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

if [[ ! -f "$TMPPREFIX/colors.sh" ]]; then
    ink -c green -- '- Generating Colors Bundle -'

    {
        dircolors -b "$XDG_CONFIG_HOME/ls/LS_COLORS"
        available=(g++ gas head make ld tail /usr{,/local}/share/grc/*(N.:e))
        installed=${available:*commands}
        disabled=(ls)
        for cmd (${available:|disabled}) print -- "alias '${cmd}'='grc --colour=auto ${cmd}'"
    } | > "$TMPPREFIX/colors.sh"
fi

source "$TMPPREFIX/colors.sh"
