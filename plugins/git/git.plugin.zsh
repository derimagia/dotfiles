alias g="git"
alias st='stree'
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # Git Root

# Git Rebase
function rebase() {
    printf "Stash? (y/n): "
    read -r shouldStash

    if [[ "$shouldStash" = "n" ]]; then
        shouldStash=false
    else
        shouldStash=true
        git stash
    fi

    git log --color --graph --pretty=format:'%Cgreen%h%Creset %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit | cat -n | less

    printf "Commit #: "
    read -r commit

    git rebase -i HEAD~$commit

    if [[ $shouldStash -eq true ]]; then
        git stash pop >/dev/null
    fi
}

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
