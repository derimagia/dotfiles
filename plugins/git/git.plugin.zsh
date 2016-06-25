alias g="git"
alias st='stree'
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # Git Root

# Clone and Open Drupal Project
function datom() {
  dclone $1 && atom .
}

# Go to project folders
function c() {
  if [ $# -eq 0 ]; then
    cd $(ghq list --full-path | fzf-tmux)
  else
    cd $(ghq list --full-path | fgrep $1 | fzf-tmux --select-1)
  fi
}

# Open dotfiles
function dopen() {
  atom $DOTFILES
}
