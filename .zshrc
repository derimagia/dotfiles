#!/usr/bin/env zsh

#zmodload zsh/zprof
zmodload -F zsh/stat b:zstat

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
    plugin_files=($DOTFILES/plugins/**/*.vital.zsh $DOTFILES/plugins/**/*.plugin.zsh)

    # Autoload files
    autoload_files=($DOTFILES/plugins/**/autoload/*)
    fpath+=($autoload_files:h) && autoload -Uz ${autoload_files:t}

    for plugin_file in $plugin_files; do
        source $plugin_file
    done

    # Add bin to path
    path=(
        $DOTFILES/plugins/**/bin/(N)
        $path
    )
}

compinit -C -d "$TMPPREFIX/zcompdump"
zcompile "$TMPPREFIX/zcompdump" &!

#zprof | less
