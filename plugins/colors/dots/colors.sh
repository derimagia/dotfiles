#!/usr/bin/env bash
[[ -d /usr/local/etc ]] || exit 34

symlink-files $DOTFILES/plugins/colors/etc/grc.conf /usr/local/etc/
