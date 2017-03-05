#!/usr/bin/env zsh

#zmodload zsh/zprof
zmodload -F zsh/stat b:zstat

typeset -gU fpath path manpath

export TMPPREFIX="$XDG_CACHE_HOME/zsh"; [[ -d "$TMPPREFIX" ]] || mkdir -p $TMPPREFIX

# General Terminal Options
# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
setopt \
    COMPLETE_ALIASES MULTIOS AUTO_CD \
    BEEP INTERACTIVE_COMMENTS MAGIC_EQUAL_SUBST SHORT_LOOPS \
    EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_IGNORE_DUPS \
    KSH_OPTION_PRINT

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv

# Local
[[ -f $ZDOTDIR/.zlocalrc ]] && source $ZDOTDIR/.zlocalrc

bindkey -e

# Load all files
() {
    local plugin_file plugin_files autoload_files
    plugin_files=(
        $ZDOTDIR/plugins/*.vital.zsh
        $ZDOTDIR/plugins/*.plugin.zsh
    )

    # Autoload files
    autoload_files=($ZDOTDIR/plugins/autoload/*)

    for plugin_file in $plugin_files; do
        source $plugin_file
    done

    fpath=($autoload_files:h $fpath) && autoload -Uz ${autoload_files:t}

    # Add bin to path
    local plugin_binary_paths=($ZDOTDIR/plugins/bin/(N))
    path=(
        ${plugin_binary_paths%/}
        $path
    )

    # Post Plugin is done after compinit.
    plugin_files=(
        $ZDOTDIR/plugins/*.post-plugin.zsh
    )

    for plugin_file in $plugin_files; do
        source $plugin_file
    done

    compinit -C -d "$TMPPREFIX/zcompdump"
    zcompile "$TMPPREFIX/zcompdump" &!
}

# Clean dead files, hopefully this can eventually be removed.
{
   cd $HOME && rm -rf .ansibe .ansible_galaxy .gitignore_global .hgignore_global .DS_Store .bash_history
}&!

#zprof | less

