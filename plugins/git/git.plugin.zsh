alias g="git"
alias gup='gitup'
alias diffg="git diff --color-words --no-index"

# Open a module in idea
dmod() {
    clone -d $1 && idea .
}

# Clone using Drupal
dclone() {
    clone -d $1
}

# Open dotfiles
dopen() {
    idea $DOTFILES
}

# Go to project folders
c() {
    local gitlist=($(ghq list --full-path))
    local projectfiles=($(command ls -1 $PROJECTS_DIR))
    projectfiles=($PROJECTS_DIR/$projectfiles[@])

    local fulllist=($gitlist $projectfiles)

    if [ $# -eq 0 ]; then
        cd $(print -l $fulllist | fzf-tmux)
    else
        cd $(print -l $fulllist | fgrep $1 | fzf-tmux --select-1)
    fi
}
