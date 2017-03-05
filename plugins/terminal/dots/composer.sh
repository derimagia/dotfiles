#!/usr/bin/env zsh

composer global update

composer global config minimum-stability dev

(( $+commands[cgr] )) || composer global require consolidation/cgr

composer global require hirak/prestissimo

(( $+commands[drush] )) || cgr --stability dev drush/drush:dev-master
(( $+commands[terminus] )) || cgr --stability dev pantheon-systems/terminus:dev-master
(( $+commands[phpmd] )) || cgr phpmd/phpmd

# Update cgr files
cgr update
