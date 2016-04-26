# Setting Terminal
export TERM='xterm-256color';
[ -n "$TMUX"  ] && export TERM=screen-256color

# Aliases
alias re='. ~/.zshrc'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias fs='stat -c "%s Bytes"' # File Size
alias la='ls -l'
alias l='k -Ah'
alias map="xargs -n1"
alias time="command time" # I never want the builtin
alias man="mangle" # This should be a drop-in change, let's me do "man ls -A"
alias dottime="/usr/bin/time zsh -i -c exit"
alias '?'='echo $?'
alias mou="open /Applications/Mou.app" # Mou!

# General Terminal Options
setopt COMPLETE_ALIASES MULTIOS PUSHD_TO_HOME AUTOCD EXTENDED_GLOB RC_EXPAND_PARAM BEEP INTERACTIVECOMMENTS


# General Bindings and Widgets
bindkey -e  # emacs key bindings

autoload -U edit-command-line
zle -N edit-command-line

expand-aliases() {
    unset 'functions[_expand-aliases]'
    functions[_expand-aliases]=$BUFFER
    (($+functions[_expand-aliases])) &&
    BUFFER=${functions[_expand-aliases]#$'\t'} &&
    CURSOR=$#BUFFER
}

__fzfcmd() {
  [ ${FZF_TMUX:-1} -eq 1 ] && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

fzf-history-widget() {
  local selected num
  selected=( $(fc -l 1 | $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r ${=FZF_CTRL_R_OPTS} -q "${LBUFFER//$/\\$}") )
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
}

_fzf_compgen_path() {
  ag -g "" "$1"
}

_fzf_compgen_dir() {
    find -L "$1" \
      -name .git -prune -o -name .svn -prune -o -type d \
      -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
}

zle -N fzf-history-widget
zle -N expand-aliases

bindkey '^ ' magic-space           # control-space to bypass completion
bindkey -M isearch ' ' magic-space # normal space during search

bindkey '\ev' edit-command-line # Vi Mode
bindkey '\ee' expand-aliases

zmodload zsh/terminfo
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

bindkey '^R' fzf-history-widget

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
setopt HISTIGNORESPACE EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_DUPS

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

alias ccat='pygmentize -O style=monokai -f console256 -g'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tail='multitail';
alias top='htop';

export GREP_OPTIONS='--color=auto';
eval "$(dircolors -b $HOME/.dircolors)"


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='underline'
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'

