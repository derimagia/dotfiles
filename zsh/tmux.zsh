# Auto Start Tmux

if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" ]]; then
  SESSIONNAME="base"
  
  if tmux has-session -t $SESSIONNAME 2>/dev/null; then
      tmux attach-session -t $SESSIONNAME
  else
      tmux new-session -s $SESSIONNAME
  fi
fi
