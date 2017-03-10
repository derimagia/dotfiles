#!/usr/bin/env zsh

(( $+commands[node] )) || exit 34

ink -l -c green -- "-- Configuring NPM"
npm --global config set cache $XDG_CACHE_HOME/npm

ink -l -c green -- "-- Installing npm Packages"
npm install -g \
    grunt \
    gulp \
    bower \
    yo \
    coffee-script \
    fkill-cli \
    tldr \
    speed-test \
    spoof \
    ctrace \
    git-open \
    babel-cli


