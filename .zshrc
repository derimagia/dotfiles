#!/usr/bin/env zsh

# PLATFORM
export SHELL_PLATFORM='unknown'
case "$(print "$OSTYPE" | tr '[:upper:]' '[:lower:]')" in
    *'linux'*) SHELL_PLATFORM='linux' ;;
    *'darwin'*) SHELL_PLATFORM='osx' ;;
esac

# Init Zplug
ZPLUG_HOME=$HOME/.zplug
{ [[ -d $ZPLUG_HOME ]] || git clone https://github.com/zplug/zplug $ZPLUG_HOME }; source $ZPLUG_HOME/init.zsh

zplugs=() # Reset zplugs

local vital_paths autoload_files plugin_files postinit_files
for plugin_path in $DOTFILES/plugins/*; do
    vital_paths=( $plugin_path/*.vital.zsh(N) )
    autoload_files=($plugin_path/autoload/*(N))
    plugin_files=($plugin_path/*.plugin.zsh(N))
    postinit_files=($plugin_path/*.postinit.zsh(N))
    osx_files=($plugin_path/*.osx.zsh(N))

    [[ -n $vital_paths ]] && zplug $plugin_path, use:'*.vital.zsh', nice:-1, from:local # Vital Files are Nice
    [[ -n $osx_files ]] && zplug $plugin_path, use:'*.osx.zsh', as:plugin, nice:3, from:local, if:'[[ $SHELL_PLATFORM == "osx" ]]'
    [[ -n $plugin_files ]] && zplug $plugin_path, use:'*.plugin.zsh', as:plugin, nice:3, from:local
    [[ -n $postinit_files ]] && zplug $plugin_path, use:'*.postinit.zsh', as:plugin, nice:10, from:local
    [[ -d $plugin_path/bin ]] && zplug $plugin_path, as:command, use:'bin/*', from:local
    [[ -n $autoload_files ]] && fpath+=$plugin_path/autoload && autoload_filenames=${(@)autoload_files:t} && autoload -Uz ${=autoload_filenames}
done

zplug mafredri/zsh-async, use:"" # Just download the repo
zplug derimagia/base16-builder, use:output/shell/base16-oceanicnext.dark.sh
zplug junegunn/fzf, as:command, use:'bin/fzf-tmux', if:"($+commands[fzf])"
zplug junegunn/fzf, use:shell/completion.zsh, if:"($+commands[fzf])"
zplug ogham/exa, from:gh-r, as:command
zplug MarianoGappa/jira-cli, use:jira.sh

# Themes
zplug sindresorhus/pure

# Packages
zplug trapd00r/LS_COLORS
zplug zsh-users/zsh-completions, use:src
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug derimagia/zsh-syntax-highlighting, nice:10 # Change back to zsh-users/zsh-syntax-highlighting when it plays well with zsh-autosuggest

# OSX
[[ -f $HOMEBREW_PREFIX/etc/brew-wrap ]] && zplug $HOMEBREW_PREFIX/etc/brew-wrap, from:local

{zplug check || zplug install}&!

zplug load

DOTFILES_LOADED=1
