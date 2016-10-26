#!/usr/bin/env zsh

composer global update

# @TODO: Confirm: We have composer.json so this isn't needed I think
# (( $+commands[cgr] )) || composer global require hirak/cgr
# composer global require hirak/prestissimo

(( $+commands[drush] )) || cgr --stability dev drush/drush:dev-master
(( $+commands[terminus] )) || cgr --stability dev pantheon-systems/terminus:dev-master
(( $+commands[phpmd] )) || cgr phpmd/phpmd

# Update cgr files
cgr update
