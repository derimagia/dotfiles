#!/usr/bin/env zsh

#zmodload zsh/zprof
zmodload -F zsh/stat b:zstat

# make path, fpath, manpath linked and unique
typeset -gU fpath path manpath

# Set up TMPPREFIX
export TMPPREFIX="$XDG_CACHE_HOME/zsh"

# Create $TMPPREFIX
mkdir -p $TMPPREFIX

# General Terminal Options
# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
setopt \
    MULTIOS AUTO_CD \
    BEEP INTERACTIVE_COMMENTS MAGIC_EQUAL_SUBST SHORT_LOOPS \
    EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_IGNORE_DUPS \
    KSH_OPTION_PRINT TRANSIENT_RPROMPT

# Autoload needed functions, bashcompinit is only needed for kubectl, hopefully we can remove
autoload -Uz add-zsh-hook compinit zmv zrecompile bashcompinit promptinit

# Reset key bindings
bindkey -e

# ZSH Options
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# bracketed-paste-url-magic is a simplier version of bracketed-paste-magic
autoload -Uz bracketed-paste-url-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-url-magic
zle -N self-insert url-quote-magic

# fasd
[[ -d $XDG_DATA_HOME/fasd ]] || mkdir -p $XDG_DATA_HOME/fasd; _FASD_DATA=$XDG_DATA_HOME/fasd/fasd
[[ -s $TMPPREFIX/fasd-init.sh ]] || fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $TMPPREFIX/fasd-init.sh
source $TMPPREFIX/fasd-init.sh

# Load all files
() {
    # Autoload files
    local autoload_files=($ZDOTDIR/autoload/*)
    fpath+=($autoload_files:h) && autoload -U ${autoload_files:t}

    local plugin_file plugin_files=(
        $ZDOTDIR/*.plugin.zsh
        $ZDOTDIR/prompt.zsh
        $ZDOTDIR/antibody.zsh
    )

    for plugin_file ($plugin_files) source $plugin_file
}

zrecompile -qp -- $TMPPREFIX/zcompdump.zwc $TMPPREFIX/zcompdump
compinit -C -d $TMPPREFIX/zcompdump

# Local rc file
[[ -f $ZDOTDIR/.zlocalrc ]] && source $ZDOTDIR/.zlocalrc

# Hook for desk activation
if [[ -n "$DESK_ENV" ]] {
    source "$DESK_ENV"
    if [[ -z $DESK_INIT ]] {
        # @TODO Make this only happen once, is there a better way to do this?
        export DESK_INIT=1

        # Only cd if we are in the home directory which is the "default" directory
        [[ -n $PROJECT_PATH && $PWD == $HOME ]] && cd $PROJECT_PATH
        [[ -n $DRUSH_ALIAS ]] && drush site-set $DRUSH_ALIAS # Faster way to do this?
    }
}

# zprof | less

