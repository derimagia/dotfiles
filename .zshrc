#!/usr/bin/env zsh

zmodload zsh/zprof
zmodload -F zsh/stat b:zstat

# Autoload needed functions
autoload -Uz add-zsh-hook compinit

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

# Cleanup
unset autoload_files plugin_files plugin_file

if [[ -d /usr/local/share/zsh/site-functions ]]; then
    # Reorder fpath
    fpath=(
        /usr/local/share/zsh/site-functions
        $fpath
    )
fi

#zprof | less
