#!/usr/bin/env zsh

#zmodload zsh/zprof
zmodload -F zsh/stat b:zstat

# make path, fpath, manpath linked and unique
typeset -gU fpath path manpath

# Set up TMPPREFIX
export TMPPREFIX="$XDG_CACHE_HOME/zsh"; [[ -d "$TMPPREFIX" ]] || mkdir -p $TMPPREFIX

# General Terminal Options
# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
setopt \
    MULTIOS AUTO_CD \
    BEEP INTERACTIVE_COMMENTS MAGIC_EQUAL_SUBST SHORT_LOOPS \
    EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_IGNORE_DUPS \
    KSH_OPTION_PRINT TRANSIENT_RPROMPT

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv

# Reset key bindings
bindkey -e

# ZSH Options
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
DISABLE_UNTRACKED_FILES_DIRTY=true

# Local rc file
[[ -f $ZDOTDIR/.zlocalrc ]] && . $ZDOTDIR/.zlocalrc

# Add bin to path
path=(
    $ZDOTDIR/plugins/bin
    $path
)

# Load all files
() {
    local plugin_file plugin_files=(
        $ZDOTDIR/plugins/*.vital.zsh
        $ZDOTDIR/plugins/*.plugin.zsh
        $ZDOTDIR/plugins/*.post-plugin.zsh
    )

    local compiled_file="$TMPPREFIX/zcompdump.zwc"

    for plugin_file ($plugin_files) . $plugin_file

    # Autoload files
    local autoload_files=($ZDOTDIR/plugins/autoload/*)
    fpath+=($autoload_files:h) && autoload -Uz ${autoload_files:t}
    compinit -C -d "$TMPPREFIX/zcompdump"
    zcompile $compiled_file "$TMPPREFIX/zcompdump" &!
}

{
    # Clean dead files, hopefully this can eventually be removed.
    rm -rf ~/.ansible ~/.ansible_galaxy ~/.gitignore_global ~/.hgignore_global ~/.DS_Store ~/.bash_history
}&!

# Hook for desk activation
if [[ -n "$DESK_ENV" ]] {
    source "$DESK_ENV"
    if [[ -z $DESK_INIT ]] {
        # @TODO Make this only happen once, is there a better way to do this?
        export DESK_INIT=1
        [[ -n $PROJECT_PATH ]] && cd $PROJECT_PATH
        [[ -n $DRUSH_ALIAS ]] && drush site-set $DRUSH_ALIAS # Faster way to do this?ss
    }
}

#zprof | less

