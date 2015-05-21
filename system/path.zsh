export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export DASHBREWPATH=/vagrant/dashbrew/public

# ZSH Directory, ./bin Directory
PATH="./bin:$ZSH/bin:$PATH"

# Coreutils
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
