#!/usr/bin/env zsh

if (( ! $+commands[python] )); then
  ink -l -c red -- "-- Python is not installed. Skipping dot."
  return 1
fi

if (( ! $+commands[pip] )); then
  ink -l -c red -- "-- Pip is not installed. Skipping dot."
  return 1
fi

pip install -U \
    pip setuptools \
    virtualenv \
    livestreamer \
    pygments \
    tmuxp \
    http-prompt

local pygmentspath=$(python -c "import pygments, inspect, os; print(os.path.dirname(os.path.abspath(inspect.getsourcefile(pygments))))")/styles
if [[ ! -f "$pygmentspath/base16_oceanicnext_dark.py" ]]; then
  ink -l -c magenta -- "-- Adding Pygments Color"
  cp $DOTFILES/plugins/apps/python/base16_oceanicnext_dark.py $pygmentspath/
fi
