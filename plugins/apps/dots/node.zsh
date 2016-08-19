#!/usr/bin/env zsh

if (( ! $+commands[node] )); then
  ink -l -c red "Node is not installed. Skipping Dot."
  return 1
fi

npm install -g \
    grunt \
    gulp \
    bower \
    newman \
    yo \
    coffee-script \
    bless \
    tldr \
    speed-test \
    spoof \
    castnow \
    ctrace \
    hpm-cli


hpm install \
    hyperterm-open-devtools \
    hyperterm-tab-icons \
    hyperterm-1password \
    hyperterm-snazzy \
    hyperterm-blink
    hyperlinks-iterm
