#!/usr/bin/env zsh

# Autoload needed functions
autoload -Uz add-zsh-hook compinit

function load_files() {
    local -a autoload_files plugin_files plugin_file
    plugin_files=($DOTFILES/plugins/**/*.vital.zsh $DOTFILES/plugins/**/*.plugin.zsh)

    # OSX Files
    [[ $SHELL_PLATFORM == "osx" ]] && plugin_files+=($DOTFILES/plugins/**/*.osx.zsh)

    # Add Zplug to the end. This will run compinit.
    plugin_files+=($DOTFILES/plugins/external/zplug.zsh)

    autoload_files=($DOTFILES/plugins/**/autoload/*)
    fpath+=($autoload_files:h) && autoload -Uz ${autoload_files:t}

    for plugin_file in $plugin_files; do
        source $plugin_file
    done
}

load_files

# Reorder fpath
fpath=(
    /usr/local/share/zsh/site-functions
    $fpath
)
