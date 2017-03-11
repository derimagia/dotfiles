#!/usr/bin/env zsh

[[ $OSTYPE =~ darwin ]] || exit 34

local PHP_CONF_DIRS=($HOMEBREW_PREFIX/etc/php/7.*/conf.d(N))

[[ -n $PHP_CONF_DIRS ]] || (ink -c red 'PHP Config Directory not found.' && exit 1)

cat > $PHP_CONF_DIRS/zcustom.ini <<-INI
# Generated from Dot
[Date]
date.timezone=America/New_York
INI

ink -c green "[PHP] Saved Custom Config"

# Getting an error with php when we turn on file opcache for cli...
# local OPCACHE_TMP_PATH=/tmp/php/opcache
# mkdir -p $OPCACHE_TMP_PATH
#[Opcache]
#opcache.enable_cli=1
#opcache.file_cache=$OPCACHE_TMP_PATH
#opcache.file_cache_only=1
