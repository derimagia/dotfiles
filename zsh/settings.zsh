# Install all casks to /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_BREWFILE=$DOTFILES/apps/Brewfile
export HOMEBREW_PREFIX=/usr/local
export GHQ_ROOT=$HOME/dev/src
export GOPATH=$HOME/dev/go
export JAVA_HOME="$(/usr/libexec/java_home)"
export MANPAGER="less -X"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
export FZF_DEFAULT_OPTS="--inline-info"

setopt COMPLETE_ALIASES MULTIOS PUSHD_TO_HOME AUTOCD EXTENDED_GLOB RC_EXPAND_PARAM BEEP
setopt INTERACTIVECOMMENTS HISTIGNORESPACE EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY HIST_BEEP

HISTFILE="$HOME/.zhistory"       # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.

DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

[[ -f "$HOME/.localrc" ]] && source $HOME/.localrc

# ZSH Directory, ./bin Directory, gopath
PATH="./bin:$DOTFILES/bin:$PATH:$GOPATH/bin"

# Coreutils
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Android SDK Tools
PATH="$HOME/Library/Android/sdk/tools:$PATH"

# Key Combinations
zmodload zsh/terminfo

bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

# fpath
fpath=($HOMEBREW_PREFIX/share/zsh-completions $DOTFILES/autocomplete $fpath)
