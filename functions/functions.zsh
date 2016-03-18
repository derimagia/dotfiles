DIR=`dirname $0`
source $DIR/file-functions.zsh
source $DIR/processing-functions.zsh

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Create a new directory and enter it
function md() {
    mkdir -p "$@" && cd "$@"
}

# List all files, long format, colorized, permissions in octal
function la(){
 	ls -l  "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}

# Go to project folders
function c() {
  if [ $# -eq 0 ]; then
    cd $(ghq list --full-path | peco)
  else
    cd $(ghq list --full-path | fgrep $1 | peco --select-1)
  fi
}

# Clone and CD
function clone () {
  ghq get -u -p $1 && ghq look $1
}

# Clone Drupal Project
function dclone() {
  clone "https://git.drupal.org/project/$1.git"
}

# Clone and Open Drupal Project
function datom() {
  dclone $1 && atom .
}

# Open dotfiles
function dopen() {
  atom $ZSH
}

# All the dig info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

# Open in Man
function dman() {
	open "dash://manpages:$*"
}

# Open in Dash
function dash() {
	open "dash://$*"
}

# Run an Android Activity
function adb-run() {
  adb shell monkey -p `cat .identifier` -c android.intent.category.LAUNCHER 1
}

# Switchs Java Home
function jhome () {
  export JAVA_HOME=`/usr/libexec/java_home $@`
  echo "JAVA_HOME:" $JAVA_HOME
  echo "java -version:"
  java -version
}
