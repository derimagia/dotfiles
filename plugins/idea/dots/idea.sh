#!/usr/bin/env zsh

[[ $OSTYPE =~ darwin ]] || exit 34

# Actual Source Files/Folders
source_files=($DOTFILES/plugins/idea/etc/*)

for idea_pref_folder in ~/Library/Preferences/{IntelliJ,PhpStorm,PyCharm,DataGrip}*(N); do
    symlink-files "$source_files" "$idea_pref_folder"
    clean-symlinks "$idea_pref_folder"
done
