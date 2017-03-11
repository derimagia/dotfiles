#!/usr/bin/env zsh

[[ $OSTYPE =~ darwin ]] || exit 34

ink -c green "Removing xcode signature"
sudo codesign --remove-signature /Applications/Xcode.app
