#!/usr/bin/env zsh

if (( ! $+commands[node] )); then
  ink -l -c red -- "-- Node is not installed. Skipping Dot."
  return 1
fi

ink -l -c green -- "-- Installing npm Packages"
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
    yarn \
    electron \
    babel-cli \
    hpm-cli

ink -l -c green -- "-- Installing hpm Packages"

# TODO: Update this when hpm-cli updates to support bulk
hpm install hyperterm-open-devtools 2>/dev/null
hpm install hyperterm-tab-icons 2>/dev/null
hpm install hyperterm-1password 2>/dev/null
hpm install hyperterm-snazzy 2>/dev/null
hpm install hyperterm-blink 2>/dev/null
hpm install hyperlinks-iterm 2>/dev/null

exit 0
