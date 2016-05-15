alias g="git"
alias st='stree'
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # Git Root
alias gg="ghq -p -u"


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

# Clone and CD
function clone () {
  ghq get -u -p $1 && ghq look $1
}

# Clone Drupal Project
function dclone() {
  clone "https://git.drupal.org/project/$1.git"
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

