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
typeset -gA ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[default]='none'
# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
# ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan,underline'
# ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=magenta,underline'
# ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=green,underline'
# ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[assign]='none'
# ZSH_HIGHLIGHT_STYLES[redirection]='none'
ZSH_HIGHLIGHT_STYLES[comment]='fg=green,bold'
# ZSH_HIGHLIGHT_STYLES[arg0]=

# Other
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='underline,bold'

# Brackets
# ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
# ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=cyan,bold'
# ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

if [[ ! -s $TMPPREFIX/dircolors-init.sh ]]; then
    dircolors -b $XDG_CONFIG_HOME/ls/LS_COLORS >| $TMPPREFIX/dircolors-init.sh
fi

source $TMPPREFIX/dircolors-init.sh
