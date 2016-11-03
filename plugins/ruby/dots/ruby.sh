#!/usr/bin/env zsh

(( $+commands[gem] )) || exit 34

gem install \
    bundler \
    compass \
    lolcat
