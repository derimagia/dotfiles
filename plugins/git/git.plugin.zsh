if (( $+commands[hub] )); then
    alias g="hub"
    alias git="hub"
else
    alias g="git"
fi

alias gup='gitup'
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # Git Root


# Open a module in idea
function dmod() {
  clone -d $1 && idea .
}

# Clone using Drupal
function dclone() {
  clone -d $1
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
  idea $DOTFILES
}
