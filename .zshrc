#!/usr/bin/env zsh

zmodload zsh/zprof
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

plugin_files=($DOTFILES/plugins/**/*.vital.zsh $DOTFILES/plugins/**/*.plugin.zsh)

# OSX Files
[[ $SHELL_PLATFORM == "macos" ]] && plugin_files+=($DOTFILES/plugins/**/*.macos.zsh)

plugin_files+=($DOTFILES/plugins/external/antibody.zsh)

# Autoload files
autoload_files=($DOTFILES/plugins/**/autoload/*)
fpath+=($autoload_files:h) && autoload -Uz ${autoload_files:t}

# Add bin to path
path=($DOTFILES/plugins/**/bin/(N) $path)

for plugin_file in $plugin_files; do
    source $plugin_file
done

# Cleanup
unset autoload_files plugin_files plugin_file

# Reorder fpath
fpath=(
    /usr/local/share/zsh/site-functions
    $fpath
)

compinit -C -d "$DOTFILES_CACHE_DIR/zcompdump"
zcompile "$DOTFILES_CACHE_DIR/zcompdump" &!

#zprof | less
