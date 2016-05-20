#!/usr/bin/env zsh

# Init Zplug
ZPLUG_HOME=$HOME/.zplug
{ [[ -d $ZPLUG_HOME ]] || git clone https://github.com/zplug/zplug $ZPLUG_HOME }; source $ZPLUG_HOME/init.zsh

zplugs=() # Reset zplugs
for plugin_path in $DOTFILES/plugins/*; do
    local vital_paths=($plugin_path/*.vital.zsh(N-))
    local autoload_files=($plugin_path/autoload/*(N-))
    local plugin_files=($plugin_path/*.plugin.zsh(N-))

    [[ -n $vital_paths ]] && zplug $plugin_path, use:'*.vital.zsh', nice:-1, from:local # Vital Files are Nice
    [[ -n $plugin_files ]] && zplug $plugin_path, use:'*.plugin.zsh', as:plugin, nice:3, from:local
    [[ -d $plugin_path/bin ]] && zplug $plugin_path, as:command, use:'bin/*', from:local
    [[ -n $autoload_files ]] && fpath+=$plugin_path/autoload && autoload_filenames=${(@)autoload_files:t} && autoload -Uz ${=autoload_filenames}
done

zplug derimagia/base16-builder, use:output/shell/base16-oceanicnext.dark.sh
zplug junegunn/fzf-bin, from:gh-r, as:command, rename-to:fzf
zplug junegunn/fzf, as:command, use:'bin/fzf-tmux'
zplug junegunn/fzf, use:shell/completion.zsh
zplug ogham/exa, from:gh-r, as:command

# Themes
zplug mafredri/zsh-async, nice:-10 # Dependnecy on some things
zplug sindresorhus/pure

# Packages
zplug rcmdnk/homebrew-file, as:plugin, use:etc/brew-wrap; zplug rcmdnk/homebrew-file, as:command, use:bin/brew-file
zplug zsh-users/zsh-completions, use:src
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-syntax-highlighting, nice:10  # @TODO Autosuggestion and Syntax Highlighting conflict when you reload zsh config files using . ~/.zshrc.

#zplug check || zplug install
#export ZPLUG_USE_CACHE=false &&
#zplug load --verbose
zplug load

DOTFILES_LOADED=1
