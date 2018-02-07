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
TMPPREFIX="$XDG_CACHE_HOME/zsh"

# Create $TMPPREFIX and "$XDG_DATA_HOME/zsh"
mkdir -p "$TMPPREFIX" "$XDG_DATA_HOME/zsh"

# General Terminal Options
# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
setopt \
    MULTIOS AUTO_CD \
    BEEP INTERACTIVE_COMMENTS MAGIC_EQUAL_SUBST SHORT_LOOPS \
    EXTENDED_HISTORY SHARE_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_IGNORE_DUPS \
    KSH_OPTION_PRINT

# Autoload needed functions
autoload -Uz add-zsh-hook compinit zmv zrecompile promptinit bracketed-paste-url-magic url-quote-magic

# Reset key bindings
bindkey -e

# ZSH Options
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# fasd
if (( $+commands[fasd] )) {
    [[ -d $XDG_DATA_HOME/fasd ]] || mkdir -p $XDG_DATA_HOME/fasd
    [[ -s $TMPPREFIX/fasd-init.sh ]] || fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $TMPPREFIX/fasd-init.sh
    export _FASD_DATA=$XDG_DATA_HOME/fasd/fasd
    source $TMPPREFIX/fasd-init.sh
}

# Load all files
() {
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
        jocelynmallon/zshmarks
    )
    
    if [[ ! -s $TMPPREFIX/antibody-plugins.sh ]] {
        ink -c green -- '- Generating Antibody Bundle -'

        # antibody doesn't seem to do detect fpaths and expects the plugin file to have it.
        cat > $TMPPREFIX/antibody-plugins.sh <<ZSH
$(echo ${(F)antibody_plugins} | antibody bundle)
fpath+=($XDG_CACHE_HOME/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-jocelynmallon-SLASH-zshmarks/functions)
ZSH
    } 

    source $TMPPREFIX/antibody-plugins.sh
}

bindkey '^X^_' redo
bindkey '^[[A' history-substring-search-up  # Sourcing after syntax-highlighting.
bindkey '^[[B' history-substring-search-down
bindkey '^ ' expand-all-aliases

compinit -C -d $TMPPREFIX/zcompdump
zrecompile -qp -- $TMPPREFIX/zcompdump

# Local rc file
[[ -f $ZDOTDIR/.zlocalrc ]] && source $ZDOTDIR/.zlocalrc

# Hook for desk activation
[[ -n "$DESK_ENV" ]] && source "$DESK_ENV"

(( $PROFILING )) && zprof
