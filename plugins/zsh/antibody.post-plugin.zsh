if [[ ! -s $TMPPREFIX/antibody-plugins.sh ]]; then
    plugin_dir=${0:a:h}
    # @TODO: Fork antibody?, paths are kind of obnoxious
    echo "ANTIBODY_PATH='$(antibody p)'" >| $TMPPREFIX/antibody-plugins.sh
    antibody bundle < $plugin_dir/plugins.txt >>| $TMPPREFIX/antibody-plugins.sh
fi

source $TMPPREFIX/antibody-plugins.sh

# This needs to run after sourcing syntax-highlighting.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
