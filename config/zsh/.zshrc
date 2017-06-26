#!/usr/bin/env zsh
(( $PROFILING )) && zmodload zsh/zprof

# Go
typeset -TUx GOPATH gopath

# make path, fpath, manpath linked and unique
typeset -gU fpath path manpath

gopath=(
    $HOME/go
)

# Mac Only
if [[ $OSTYPE =~ darwin ]] {
    export HOMEBREW_PREFIX=/usr/local # hardcoded for now, brew --prefix does it and should be "fast", but there's no point in it
    export HOMEBREW_NO_ANALYTICS=1 # I don't really mind for privacy's sake, I just haven't looked at the code for it.
    export HOMEBREW_BREWFILE=$XDG_CONFIG_HOME/brew/brewfile

    # Add these in the vital file since we want them before our own paths
    fpath=(
        $HOMEBREW_PREFIX/share/zsh-completions
        $HOMEBREW_PREFIX/share/zsh/site-functions
        $fpath
    )

    path=(
        $HOMEBREW_PREFIX/sbin
        $HOMEBREW_PREFIX/bin
        $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
        /usr/libexec
        $path
    )

    manpath=(
        $HOMEBREW_PREFIX/share/man
        $HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman
        /usr/local/opt/findutils/share/man
        $manpath
    )
}

# paths
path=(
    $ZDOTDIR/bin
    $ZDOTDIR/dots
    $COMPOSER_HOME/vendor/bin
    $gopath/bin
    $path
)

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

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv zrecompile promptinit bracketed-paste-url-magic url-quote-magic

# Reset key bindings
bindkey -e

# ZSH Options
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# bracketed-paste-url-magic is a simplier version of bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-url-magic
zle -N self-insert url-quote-magic

# fasd
[[ -d $XDG_DATA_HOME/fasd ]] || mkdir -p $XDG_DATA_HOME/fasd
[[ -s $TMPPREFIX/fasd-init.sh ]] || fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $TMPPREFIX/fasd-init.sh
export _FASD_DATA=$XDG_DATA_HOME/fasd/fasd
source $TMPPREFIX/fasd-init.sh

# Load all files
() {
    emulate zsh -L

    # Autoload files
    autoload_files=($ZDOTDIR/autoload/*)
    fpath+=($autoload_files:h) && autoload -U ${autoload_files:t}

    typeset -U plugin_files=(
        $ZDOTDIR/*.plugin.zsh
        $ZDOTDIR/prompt.plugin.zsh
    )
    for plugin_file ($plugin_files) source $plugin_file

    local antibody_plugins=(
        zsh-users/zsh-history-substring-search
        psprint/history-search-multi-word
        zsh-users/zsh-autosuggestions
        zsh-users/zsh-syntax-highlighting
        paulirish/git-open
    )
    [[ -s $TMPPREFIX/antibody-plugins.sh ]] || print ${(F)antibody_plugins} | antibody bundle > $TMPPREFIX/antibody-plugins.sh
    source $TMPPREFIX/antibody-plugins.sh
}

bindkey '^U' backward-kill-line
bindkey '^X^_' redo
bindkey '^[[A' history-substring-search-up  # Sourcing after syntax-highlighting.
bindkey '^[[B' history-substring-search-down
bindkey '^ ' expand-all-aliases

compinit -C -d $TMPPREFIX/zcompdump
zrecompile -qp -- $TMPPREFIX/zcompdump

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


(( $PROFILING )) && zprof
