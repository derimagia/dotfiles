#!/bin/sh

directory=$(readlink -f $(dirname $0))
theme_file="material-theme-custom.icls"

for idea_pref_folder in ~/Library/Preferences/{PhpStorm,PyCharm,IntelliJ}*; do

    file="$directory/$theme_file"
    target="$idea_pref_folder/colors/$theme_file"

    echo "Installing Idea Colors from $file to $target"
    mkdir -p "$idea_pref_folder/colors/"

    ln -sf $file $target
done;
