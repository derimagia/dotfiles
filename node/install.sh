if test ! $(which grunt)
then
  npm install grunt -g
fi

if test ! $(which gulp)
then
  npm install gulp -g
fi

if test ! $(which bower)
then
  npm install bower -g
fi

if test ! $(which newman)
then
  npm install newman -g
fi

if test ! $(which yo)
then
  npm install yo -g
fi

if test ! $(which coffee)
then
  npm install coffee-script -g
fi

if test ! $(which bless)
then
  npm install bless -g
fi

if test ! $(which tldr)
then
  npm install tldr -g
fi

if test ! $(which speed-test)
then
  npm install speed-test -g
fi

if test ! $(which spoof)
then
  npm install spoof -g
fi
