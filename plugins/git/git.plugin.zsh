if (( $+commands[hub] )); then
    alias git="hub"
fi

alias g="git"
alias gup='gitup'

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
  if [ $# -eq 0 ]; then
    cd $(ghq list --full-path | fzf-tmux)
  else
    cd $(ghq list --full-path | fgrep $1 | fzf-tmux --select-1)
  fi
}
