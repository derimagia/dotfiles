#!/usr/bin/env zsh

if [[ ! -d $ZPLG_HOME ]]; then
    mkdir $ZPLG_HOME
    chmod g-rwX "$ZPLG_HOME"
    git clone https://github.com/psprint/zplugin.git $ZPLG_HOME/bin
fi

source $ZPLG_HOME/bin/zplugin.zsh
autoload -Uz compinit
compinit

zplugin load mafredri/zsh-async
zplugin load MarianoGappa/jira-cli
zplugin load sindresorhus/pure

zplugin load zsh-users/zsh-completions
zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-history-substring-search
zplugin load derimagia/zsh-syntax-highlighting


(( $+commands[brew] )) && zplugin snippet $HOMEBREW_PREFIX/etc/brew-wrap

zplugin cdreplay -q
