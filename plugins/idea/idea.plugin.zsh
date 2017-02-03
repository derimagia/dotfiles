alias i="idea"
alias doti="i $DOTFILES"

# Edit
idea() {
    local openpath="$1"
    if [[ -z "$openpath" ]]; then
        openpath="$PWD"
    fi
    command idea $openpath
}
