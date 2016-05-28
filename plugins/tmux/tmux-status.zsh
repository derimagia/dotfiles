#!/usr/bin/env zsh

local tmux_pane=$(print "$1" | tr -d %)

function print_tmux_var() {
    printenv "TMUX_$1_${tmux_pane}"
}

local terminus_site=$(print_tmux_var TERMINUS_SITE)
local terminus_env=$(print_tmux_var TERMINUS_ENV)


local default='#[fg=default]'
local cyan='#[fg=cyan]'
local yellow='#[fg=yellow]'
local blue='#[fg=blue]'
local black='#[fg=black]'
local magenta='#[fg=magenta]'
local white='#[fg=white]'

local drush_site=$(print_tmux_var DRUSH_SITE)
local date="$(date "+%a %m$white/$cyan%d %H$white:$cyan%M$white:$cyan%S")"


if [[ -n $drush_site ]]; then
    drush_site=${drush_site//@/$white@$cyan}
fi

if [[ -n $terminus_site ]]; then
    terminus_site="$cyan$terminus_site$default"
fi

if [[ -n $terminus_site ]] && [[ -n $terminus_env ]]; then
    terminus_site="$terminus_site $white($default$terminus_env$white)$default"
fi

if [[ -n $date ]]; then
    date="$cyan$date$default"
fi

local tmux_export=(
    $terminus_site
    $drush_site
    $date
)

print $output " $default${(j:  #[fg=default]|#[fg=default]  :)tmux_export}"
