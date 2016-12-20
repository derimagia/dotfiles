#!/usr/bin/env zsh

if (( ! $+commands[npm] )); then
  ink -l -c red -- "-- Node is not installed. Skipping Dot."
  return 1
fi

ink -l -c green -- "-- Installing npm Packages"
npm install -g \
    grunt \
    gulp \
    bower \
    yo \
    coffee-script \
    bless \
    tldr \
    speed-test \
    spoof \
    ctrace \
    electron \
    babel-cli


