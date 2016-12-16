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
    pygments \
    tmuxp \
    doge \
    http-prompt

pip3 install -U \
    pip
    git-repo

pygmentspath=$(python -c "import pygments, inspect, os; print(os.path.dirname(os.path.abspath(inspect.getsourcefile(pygments))))")/styles
if [[ ! -f "$pygmentspath/base16_oceanicnext_dark.py" ]]; then
  ink -l -c magenta -- "-- Adding Pygments Color"
  cp $DOTFILES/plugins/python/etc/base16_oceanicnext_dark.py $pygmentspath/
fi
