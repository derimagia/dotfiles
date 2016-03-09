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
