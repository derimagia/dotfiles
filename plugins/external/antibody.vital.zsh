#!/usr/bin/env zsh

# Make sure we have antibody
if (( ! $+commands[antibody] )); then
    curl -s https://raw.githubusercontent.com/getantibody/installer/master/install | bash -s
fi


if [[ ! -s $TMPPREFIX/antibody-plugins-vital.sh ]]; then
    antibody bundle mafredri/zsh-async >| $TMPPREFIX/antibody-plugins-vital.sh
fi

if [[ ! -s $TMPPREFIX/antibody-plugins.sh ]]; then
    plugin_dir=${0:a:h}

    # @TODO: Fork antibody, paths are kind of obnoxious
    echo "ANTIBODY_PATH='$(antibody p)'" >| $TMPPREFIX/antibody-plugins.sh
    antibody bundle < $plugin_dir/plugins.txt >>| $TMPPREFIX/antibody-plugins.sh
fi

source $TMPPREFIX/antibody-plugins-vital.sh
source $TMPPREFIX/antibody-plugins.sh
