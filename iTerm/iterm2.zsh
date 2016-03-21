function iterm2_print_user_vars() {
  if [[ -n "$TMUX" ]]; then
    tmuxname=$(tmux display-message -p '#W')
  fi;
  iterm2_set_user_var badge "$tmuxname"
}
