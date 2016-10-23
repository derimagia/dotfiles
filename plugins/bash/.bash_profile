if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
