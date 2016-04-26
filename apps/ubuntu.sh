#!/usr/bin/env bash

sudo -v

curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -

sudo apt-get -y install \
    grc \
    tmux \
    nodejs

sudo chown -R $USER /usr/local
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
sudo ln -s ~/.fzf/bin/fzf /usr/local/bin/fzf
sudo ln -s ~/.fzf/bin/fzf /usr/local/bin/fzf-tmux