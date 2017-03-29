#!/usr/bin/env zsh

# Make sure we have antibody
if (( ! $+commands[antibody] )); then
    ink -c red "Install Antibody"
    # curl -s https://raw.githubusercontent.com/getantibody/installer/master/install | bash -s
    return
fi

if [[ ! -s $TMPPREFIX/antibody-plugins-vital.sh ]]; then
    antibody bundle mafredri/zsh-async > $TMPPREFIX/antibody-plugins-vital.sh
fi

source $TMPPREFIX/antibody-plugins-vital.sh
