if [[ ! -s $TMPPREFIX/antibody-plugins.sh ]]; then
    local plugin_dir=${0:a:h}
    echo "ANTIBODY_PATH='$(antibody p)'" >| $TMPPREFIX/antibody-plugins.sh
    antibody bundle < $plugin_dir/etc/plugins.txt >>| $TMPPREFIX/antibody-plugins.sh
fi

source $TMPPREFIX/antibody-plugins.sh

# This needs to run after sourcing syntax-highlighting.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
