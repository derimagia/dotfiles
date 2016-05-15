# Setting Terminal
if is_osx; then
    export TERM='xterm-256color';
    [ -n "$TMUX"  ] && export TERM=screen-256color
fi

# General Terminal Options
setopt COMPLETE_ALIASES MULTIOS PUSHD_TO_HOME AUTOCD EXTENDED_GLOB RC_EXPAND_PARAM BEEP INTERACTIVECOMMENTS

# General Bindings and Widgets
bindkey -e  # emacs key bindings

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line # Vi Mode

zmodload zsh/terminfo
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
setopt HISTIGNORESPACE EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_DUPS

setopt KSHOPTIONPRINT # Better Options with setopt

DISABLE_UNTRACKED_FILES_DIRTY="true"

# Colors
export CLICOLOR=1

if [ "$TERM" != dumb ] && has.command grc ; then
    alias cl='grc -es --colour=auto'
    alias configure='cl ./configure'
    alias diff='cl diff'
    alias make='cl make'
    alias gcc='cl gcc'
    alias g++='cl g++'
    alias as='cl as'
    alias gas='cl gas'
    alias ld='cl ld'
    alias netstat='cl netstat'
    alias ping='cl ping'
    alias traceroute='cl traceroute'
    alias ls='cl ls --color -CAh --group-directories-first'
    alias docker='grc docker'
    alias docker-machine='grc docker-machine'
else
    alias ls='ls --color -CAh --group-directories-first'
fi

alias ccat='pygmentize -P style=base16_ocean_dark -f console256 -g'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

export GREP_OPTIONS='--color=auto';
eval "$(dircolors -b $HOME/.dircolors)"

#export LESS_TERMCAP_DEBUG=1
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

## ZSH Highlight
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='underline'
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

## Completion
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'

# Load Fasd
has.command fasd && eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
