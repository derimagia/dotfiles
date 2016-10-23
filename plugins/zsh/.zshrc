#!/usr/bin/env zsh

#zmodload zsh/zprof
zmodload -F zsh/stat b:zstat

typeset -gU fpath path manpath

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

export TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi

# General Terminal Options
# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
setopt \
    COMPLETE_ALIASES MULTIOS PUSHD_TO_HOME AUTOCD EXTENDED_GLOB \
    RC_EXPAND_PARAM BEEP INTERACTIVECOMMENTS MAGIC_EQUAL_SUBST \
    HISTIGNORESPACE EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_DUPS \
    KSHOPTIONPRINT MAGIC_EQUAL_SUBST

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv

# Local
[[ -f $HOME/.localrc ]] && source $HOME/.localrc

# Load all files
() {
    local plugin_file plugin_files autoload_files
    plugin_files=(
        $DOTFILES/plugins/**/*.vital.zsh
        $DOTFILES/plugins/**/*.plugin.zsh
        $DOTFILES/plugins/**/*.post-plugin.zsh
    )

    # Autoload files
    autoload_files=($DOTFILES/plugins/**/autoload/*)
    fpath+=($autoload_files:h) && autoload -Uz ${autoload_files:t}

    for plugin_file in $plugin_files; do
        source $plugin_file
    done

    # Add bin to path
    local plugin_binary_paths=($DOTFILES/plugins/**/bin/(N))
    path=(
        ${plugin_binary_paths%/}
        $path
    )
}

compinit -C -d "$TMPPREFIX/zcompdump"
zcompile "$TMPPREFIX/zcompdump" &!

#zprof | less

# [[ -f ~/.travis/travis.sh ]] && source ~/.travis/travis.sh
