#!/usr/bin/env zsh

# this symlinks all the dotfiles $HOME
DOTFILES=${DOTFILES-$HOME/.dotfiles/}

link_dotfiles() {
    # finds all .dotfiles in this folder and the bin folder
    excluded=($(git --git-dir=$DOTFILES/.git check-ignore *(D)) .git .gitignore .DS_Store .editorconfig)
    excluded=($DOTFILES/$^excluded[@])

    dotfiles_all=($DOTFILES/.*)
    files=(${dotfiles_all:|excluded})
    dotfiles_source=(${dotfiles_all:|excluded})

    symlink-files "$dotfiles_source" "$HOME"
}

# Intellij Files
link_intellij() {
    # Actual Source Files/Folders
    source_files=($DOTFILES/plugins/apps/idea/*)

    if is_macos; then
        for idea_pref_folder in ~/Library/Preferences/{IntelliJ,PhpStorm,PyCharm}*(N); do
            symlink-files "$source_files" "$idea_pref_folder"
            clean-symlinks "$idea_pref_folder"
        done
    fi
}

# Extra Files
link_extras() {
    if [[ -f /usr/local/etc/grc.conf ]]; then
        symlink-files $DOTFILES/plugins/apps/grc/grc.conf /usr/local/etc/
    fi
}

link_dotfiles
link_intellij
link_extras

