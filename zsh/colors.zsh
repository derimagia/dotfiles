export TERM='xterm-256color';
export CLICOLOR=1


# Colors
alias ccat='pygmentize -O style=monokai -f console256 -g'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias docker="grc docker"
alias docker-machine="grc docker-machine"

export GREP_OPTIONS='--color=auto';
eval "$(gdircolors -b)"


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='underline'
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
