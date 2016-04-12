#!/bin/sh

cd "$(dirname "$0")"

for p in ~/Library/Preferences/{PhpStorm,PyCharm}*; do
  echo "Installing Idea Colors to $p"
  mkdir -p $p/colors/
  find . -name \*.icls -exec cp {} $p/colors/ \;
done;
