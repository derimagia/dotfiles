#!/usr/bin/env zsh

exit # Getting an error with php when we turn on file opcache for cli...

[[ $OSTYPE =~ darwin ]] || exit 34


local PHP_CONF_DIRS=($HOMEBREW_PREFIX/etc/php/7.*/conf.d(N))
local OPCACHE_TMP_PATH=/tmp/php/opcache

[[ -n $PHP_CONF_DIRS ]] || (echo 'PHP Config Directory not found.' && exit 1)

mkdir -p $OPCACHE_TMP_PATH
cat > $PHP_CONF_DIRS/zcustom-opcache.ini <<-INI
# Generated from Dot
opcache.enable_cli=1
opcache.file_cache=$OPCACHE_TMP_PATH
opcache.file_cache_only=1
INI
ink -c green "[PHP] Saved Opcache Config"

