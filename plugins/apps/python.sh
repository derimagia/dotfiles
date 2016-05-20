#!/usr/bin/env bash

pip install -U pip
pip install -U virtualenv
pip install -U livestreamer
pip install -U pygments
pip install -U http-prompt

# Install Pygments Style
if [[ -d "$ZPLUG_ROOT/repos/derimagia/base16-builder/output/pygments/" ]]; then
    echo "Adding Pygments Color"
    pygmentspath=$(python -c "import pygments, inspect, os; print os.path.dirname(os.path.abspath(inspect.getsourcefile(pygments)))")/styles
    cp $ZPLUG_ROOT/repos/derimagia/base16-builder/output/pygments/base16-oceanicnext.dark.py $pygmentspath/base16_oceanicnext_dark.py
    # Fix Class..
    sed -i "s/class base16_oceanicnext_dark/class Base16_Oceanicnext_DarkStyle/" $pygmentspath/base16_oceanicnext_dark.py
fi
