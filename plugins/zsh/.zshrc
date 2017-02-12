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
    KSHOPTIONPRINT

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv

# Local
[[ -f $HOME/.localrc ]] && source $HOME/.localrc

bindkey -e

# Load all files
() {
    local plugin_file plugin_files autoload_files
    plugin_files=(
        $DOTFILES/plugins/**/*.vital.zsh
        $DOTFILES/plugins/**/*.plugin.zsh
    )

    # Autoload files
    autoload_files=($DOTFILES/plugins/**/autoload/*)

    for plugin_file in $plugin_files; do
        source $plugin_file
    done

    fpath=($autoload_files:h $fpath) && autoload -Uz ${autoload_files:t}

    # Add bin to path
    local plugin_binary_paths=($DOTFILES/plugins/**/bin/(N))
    path=(
        ${plugin_binary_paths%/}
        $path
    )

    compinit -C -d "$TMPPREFIX/zcompdump"
    zcompile "$TMPPREFIX/zcompdump" &!

    # Post Plugin is done after compinit.
    plugin_files=(
        $DOTFILES/plugins/**/*.post-plugin.zsh
    )

    for plugin_file in $plugin_files; do
        source $plugin_file
    done
}


#zprof | less

