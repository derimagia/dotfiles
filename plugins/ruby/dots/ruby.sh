#!/usr/bin/env bash

if (( ! $+commands[gem] )); then
  ink -l -c red -- "-- Gem is not installed. Skipping dot."
  return 1
fi

gem install \
    bundler \
    compass \
    lolcat
