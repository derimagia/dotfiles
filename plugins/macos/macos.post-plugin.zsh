[[ $OSTYPE =~ darwin ]] || return

if [[ -f $HOMEBREW_PREFIX/etc/brew-wrap ]];then
  source $HOMEBREW_PREFIX/etc/brew-wrap
fi
