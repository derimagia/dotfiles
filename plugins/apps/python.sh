#!/usr/bin/env bash

pip install -U \
    pip setuptools \
    virtualenv \
    livestreamer \
    pygments \
    http-prompt

# Install Pygments Style
if [[ -d "$ZPLUG_ROOT/repos/derimagia/base16-builder/output/pygments/" ]] && [[ =python3 ]]; then
    echo "Adding Pygments Color"
    pygmentspath=$(python3 -c "import pygments, inspect, os; print(os.path.dirname(os.path.abspath(inspect.getsourcefile(pygments))))")/styles
    cp $ZPLUG_ROOT/repos/derimagia/base16-builder/output/pygments/base16-oceanicnext.dark.py $pygmentspath/base16_oceanicnext_dark.py
    # Fix Class..
    sed -i "s/class base16_oceanicnext_dark/class Base16_Oceanicnext_DarkStyle/" $pygmentspath/base16_oceanicnext_dark.py
fi
