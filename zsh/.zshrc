#!/usr/bin/env zsh

(( $PROFILING )) && zmodload zsh/zprof

# Set up TMPPREFIX
typeset -g TMPPREFIX="$XDG_CACHE_HOME/zsh"
mkdir -p "$TMPPREFIX"

# General Terminal Options
# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
setopt \
    MULTIOS AUTO_CD \
    INTERACTIVE_COMMENTS MAGIC_EQUAL_SUBST SHORT_LOOPS \
    EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_IGNORE_DUPS \
    KSH_OPTION_PRINT

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv

# Reset key bindings
bindkey -e

# ZSH Options
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# fasd
if (( $+commands[fasd] )) {
    [[ -d $XDG_DATA_HOME/fasd ]] || mkdir -p "$XDG_DATA_HOME/fasd"
    [[ -f "$TMPPREFIX/fasd-init.sh" ]] || fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$TMPPREFIX/fasd-init.sh"
    export _FASD_DATA="$XDG_DATA_HOME/fasd/fasd"
    source "$TMPPREFIX/fasd-init.sh"
}

load_custom_plugins() {
    # Mac Only
    [[ $OSTYPE =~ darwin ]] && path+=('/usr/local/sbin' '/usr/libexec')

    # Autoload files
    local autoload_files=($ZDOTDIR/autoload/*)
    fpath+=($ZDOTDIR/autoload) && autoload -U ${autoload_files:t}

    path=($ZDOTDIR/bin $path)

    typeset -U plugin_files=(
        $ZDOTDIR/*.plugin.zsh
        $ZDOTDIR/prompt.plugin.zsh
    )
    for plugin_file ($plugin_files) source "$plugin_file"
}

load_packaged_plugins() {
   local antibody_plugins=(
        zsh-users/zsh-completions
        zsh-users/zsh-history-substring-search
        psprint/history-search-multi-word
        zsh-users/zsh-autosuggestions
        zdharma/fast-syntax-highlighting
    )

    if [[ ! -s $TMPPREFIX/antibody-plugins.sh ]] {
        ink -c green -- '- Generating Antibody Bundle -'
        mkdir -p "$TMPPREFIX"
        echo ${(F)antibody_plugins} | antibody bundle > $TMPPREFIX/antibody-plugins.sh
    }

    source $TMPPREFIX/antibody-plugins.sh

    # Go
    typeset -TUx GOPATH gopath && gopath=($HOME/go)

    path+=($CARGO_HOME/bin $COMPOSER_HOME/vendor/bin $gopath/bin)
}

load_local() {
    path=($ZDOTDIR/local/bin $path)

    # Local rc file
    [[ -f $ZDOTDIR/.zlocalrc ]] && source $ZDOTDIR/.zlocalrc
}

load_custom_plugins
load_packaged_plugins

bindkey '^X^_' redo # iterm
bindkey '^[[A' history-substring-search-up # Sourcing after syntax-highlighting
bindkey '^[[B' history-substring-search-down
bindkey '^>' expand-all-aliases
bindkey '^ ' zle-set-sticky

load_local

compinit -C

() {
    autoload -Uz zrecompile
    zrecompile -p -- $ZDOTDIR/.zcompdump
    rm -f $ZDOTDIR/.zcompdump.zwc.old
}&!

(( $PROFILING )) && zprof
