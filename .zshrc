#!/usr/bin/env zsh

export DOTFILES=$HOME/.dotfiles
export HOMEBREW_PREFIX=/usr/local

[[ -d ~/.zplug ]] || git clone https://github.com/b4b4r07/zplug ~/.zplug

source ~/.zplug/zplug

zplug $HOMEBREW_PREFIX/opt/fzf/shell, from:local

zplug $DOTFILES/zsh, from:local
zplug $DOTFILES/functions, from:local

zplug supercrabtree/k
zplug chriskempson/base16-shell, of:base16-ocean.dark.sh

# Themes
zplug mafredri/zsh-async, nice:1
zplug sindresorhus/pure, nice:4

# Packages
zplug sharat87/pip-app
zplug $HOMEBREW_PREFIX/etc/brew-wrap, from:local
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-syntax-highlighting, nice:10 # Run Last
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions

if ! zplug check; then
    zplug install
fi

zplug load

eval "$(fasd --init auto)"
