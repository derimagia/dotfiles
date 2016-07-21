#!/usr/bin/env zsh

{ [[ -d $ZPLUG_HOME ]] || git clone https://github.com/zplug/zplug $ZPLUG_HOME }; source $ZPLUG_HOME/init.zsh

zplugs=() # Reset zplugs

# Use zplug for binaries in local files
zplug $DOTFILES/plugins, as:command, use:'**/bin/*', from:local

zplug mafredri/zsh-async, use:'-' # Just download the repo
zplug trapd00r/LS_COLORS, use:'-' # Just download the repo

zplug junegunn/fzf, use:shell/completion.zsh, if:"(( $+commands[fzf] ))"
zplug $HOMEBREW_PREFIX/etc/brew-wrap, from:local, if:"(( $+commands[brew] ))"
zplug MarianoGappa/jira-cli, use:jira.sh

# Themes
zplug sindresorhus/pure

# Packages
zplug zsh-users/zsh-completions, use:src
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug derimagia/zsh-syntax-highlighting, nice:10 # Change back to zsh-users/zsh-syntax-highlighting when it plays well with zsh-autosuggest

# Check in Background
# zplug check || zplug install

zplug load
