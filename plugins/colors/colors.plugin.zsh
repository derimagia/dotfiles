[[ $TERM != dumb ]] || return

autoload -Uz colors && colors

export CLICOLOR=true

GREP_OPTIONS='--color=always'

if (( $+commands[grc] )); then
    # Need to run it through stdbuf because of https://github.com/garabik/grc/issues/25
    alias cl='stdbuf -oL grc -es --colour=auto'
    alias configure='cl ./configure'
    alias diff='cl diff'
    alias make='cl make'
    alias gcc='cl gcc'
    alias g++='cl g++'
    alias as='cl as'
    alias ps='cl ps'
    alias php'cl php'
    alias dig='cl dig'
    alias gas='cl gas'
    alias mount='cl mount'
    alias ld='cl ld'
    alias mtr='sudo grc -es --colour=auto mtr'
    alias netstat='cl netstat'
    alias ping='cl ping'
    alias traceroute='cl traceroute'
    alias docker='grc docker'
    alias docker-compose='grc docker-compose'
    alias docker-machine='grc docker-machine'
fi

alias ls='ls --color=auto'
