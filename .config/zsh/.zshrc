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
    KSH_OPTION_PRINT TRANSIENT_RPROMPT

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv

bindkey -e

# zsh options
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
DISABLE_UNTRACKED_FILES_DIRTY=true

# Local
[[ -f $ZDOTDIR/.zlocalrc ]] && . $ZDOTDIR/.zlocalrc

# Add bin to path
path=(
    $ZDOTDIR/plugins/bin
    $path
)

# Load all files
() {
    local plugin_file
    local plugin_files=(
        $ZDOTDIR/plugins/*.vital.zsh
        $ZDOTDIR/plugins/*.plugin.zsh
        $ZDOTDIR/plugins/*.post-plugin.zsh
    )

    local compiled_file="$TMPPREFIX/zcompdump.zwc"

    for plugin_file in $plugin_files; do
        . $plugin_file
    done

    # Autoload files
    local autoload_files=($ZDOTDIR/plugins/autoload/*)
    fpath=($autoload_files:h $fpath) && autoload -Uz ${autoload_files:t}

    compinit -C -d "$TMPPREFIX/zcompdump"
    zcompile $compiled_file "$TMPPREFIX/zcompdump" &!
}

{
    # Clean dead files, hopefully this can eventually be removed.
    rm -rf ~/.ansibe ~/.ansible_galaxy ~/.gitignore_global ~/.hgignore_global ~/.DS_Store ~/.bash_history
}&!

# Hook for desk activation
if [[ -n "$DESK_ENV" ]]; then
    source "$DESK_ENV"
    if [[ -z $DESK_INIT ]]; then
        # @TODO Make this only happen once, is there a better way to do this?
        export DESK_INIT=1
        [[ -n $PROJECT_PATH ]] && cd $PROJECT_PATH
        [[ -n $DRUSH_ALIAS ]] && drush site-set $DRUSH_ALIAS # Faster way to do this?ss
    fi
fi

#zprof | less

