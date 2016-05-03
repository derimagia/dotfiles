# Create a new directory and enter it
take(){[ $# -eq 1 ]  && mkdir "$1" && cd "$1"}

# z is the new j? I guess?
z() {
  cd $(fasd -d "$1" | fzf-tmux --select-1)
}

f() {
  fasd -f "$1" | fzf-tmux --select-1
}

# Lazy source a function so the file doesn't get loaded until it's called
#TODO: This can probably be replaced with zsh auto loading
lazy_source () {
    eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}

# All the dig info
digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

envs() {
  alias | grep -E ${1-.} | \
    sed 's/^(\w+)(=)(.*)$/\%F{green}$1%f\033[m $2 $3/' | \
    fzf-tmux
}

escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    echo # newline
}

ip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

cpp () {
  rsync -WavP --human-readable --progress $1 $2
}

# get gzipped size
gz() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

# direct it all to /dev/null
nullify() {
  "$@" >/dev/null 2>&1
}

# Use pip without requiring virtualenv
function syspip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}