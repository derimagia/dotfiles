[[ $TERM != dumb ]] || return

autoload -Uz colors && colors

export CLICOLOR=true

GREP_OPTIONS='--color=always'

if (( $+commands[grc] )); then
    # Need to run it through stdbuf because of https://github.com/garabik/grc/issues/25
    alias cl_stdbuf='stdbuf -oL grc -es --colour=auto'
    alias cl='grc -es --colour=auto'
    alias configure='cl ./configure'
    alias diff='cl diff'
    alias make='cl make'
    alias gcc='cl gcc'
    alias g++='cl g++'
    alias as='cl as'
    alias ps='cl ps'
    alias php'cl php'
    alias dig='cl dig'
    alias mount='cl mount'
    alias ld='cl ld'
    alias mtr='sudo grc -es --colour=auto mtr'
    alias netstat='cl_stdbuf netstat'
    alias ping='cl ping'
    alias traceroute='cl traceroute'
    alias docker='cl docker'
    alias docker-compose='cl docker-compose'
    alias docker-machine='cl docker-machine'
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#export LESS_TERMCAP_DEBUG=1
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$fg[cyan]          # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_so=$fg[red]           # begin standout-mode - info box
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
export LESS_TERMCAP_ue=$'\e[0m'           # end underline

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
ZSH_HIGHLIGHT_STYLES[default]='underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='underline'
ZSH_HIGHLIGHT_STYLES[comment]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='underline,bold'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

if [[ ! -s $TMPPREFIX/dircolors-init.sh ]]; then
    dircolors -b $XDG_CONFIG_HOME/ls/LS_COLORS >| $TMPPREFIX/dircolors-init.sh
fi

source $TMPPREFIX/dircolors-init.sh
