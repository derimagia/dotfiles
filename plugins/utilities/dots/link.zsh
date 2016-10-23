#!/usr/bin/env zsh

# this symlinks all the dotfiles $HOME
DOTFILES=${DOTFILES-$HOME/.dotfiles/}

# finds all .dotfiles in this folder
excluded=($(git --git-dir=$DOTFILES/.git check-ignore *(D)) .git .gitignore .DS_Store .editorconfig)
excluded=($DOTFILES/$^excluded[@])

dotfiles_all=($DOTFILES/plugins/*/.*)
files=(${dotfiles_all:|excluded})
dotfiles_source=(${dotfiles_all:|excluded})

print -l $dotfiles_source
symlink-files "$dotfiles_source" "$HOME"
clean-symlinks "$HOME"

