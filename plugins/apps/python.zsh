#!/usr/bin/env zsh

pip install -U \
    pip setuptools \
    virtualenv \
    livestreamer \
    pygments \
    tmuxp \
    http-prompt

# Install Pygments Style
if (( $+commands[python] )); then
    echo "Adding Pygments Color"
    pygmentspath=$(python -c "import pygments, inspect, os; print(os.path.dirname(os.path.abspath(inspect.getsourcefile(pygments))))")/styles
    cp $DOTFILES/plugins/apps/python/base16_oceanicnext_dark.py $pygmentspath/
fi
