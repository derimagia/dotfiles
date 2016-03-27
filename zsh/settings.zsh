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

setopt COMPLETE_ALIASES MULTIOS PUSHD_TO_HOME AUTOCD EXTENDED_GLOB RC_EXPAND_PARAM BEEP INTERACTIVECOMMENTS

# History
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoredups:erasedups
setopt HISTIGNORESPACE EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS

DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

[[ -f "$HOME/.localrc" ]] && source $HOME/.localrc

# ZSH Directory, ./bin Directory, gopath
PATH="./bin:$DOTFILES/bin:$PATH:$GOPATH/bin"

# Coreutils
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Android SDK Tools
PATH="$HOME/Library/Android/sdk/tools:$PATH"

# fpath
fpath=($HOMEBREW_PREFIX/share/zsh-completions $DOTFILES/autocomplete $fpath)
