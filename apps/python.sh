#!/usr/bin/env bash

pip install --upgrade pip
pip install --upgrade virtualenv
pip install --upgrade livestreamer
pip install --upgrade pygments

# Install Pygments Style
if [[ -d "$ZPLUG_ROOT/repos/derimagia/base16-builder/output/pygments/" ]]; then
    echo "Adding Pygments Color"
    pygmentspath=$(python -c "import pygments, inspect, os; print os.path.dirname(os.path.abspath(inspect.getsourcefile(pygments)))")/styles
    cp $ZPLUG_ROOT/repos/derimagia/base16-builder/output/pygments/base16-ocean.dark.py $pygmentspath/base16_ocean_dark.py
    # Fix Class..
    sed -i "s/class base16_ocean_dark/class Base16_Ocean_DarkStyle/" $pygmentspath/base16_ocean_dark.py
fi
