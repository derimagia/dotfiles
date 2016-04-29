fpath=(
    "${${(%):-%N}:A:h}"/functions(N-/)
    $fpath
)

autoload -Uz dot ink

# Start an HTTP server from a directory, optionally specifying the port
#@TODO: Never use this one...
server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Create a new directory and enter it
#@TODO: Never use this one...
md() {
    mkdir -p "$@" && cd "$@"
}

# z is the new j? I guess?
z() {
  cd $(fasd -d "$1" | fzf-tmux --select-1)
}

f() {
  fasd -f "$1" | fzf-tmux --select-1
}


# Lazy source a function so the file doesn't get loaded until it's called
#TODO: This can probably be replaced with zsh auto loading
lazy_source () {
    eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}

# All the dig info
digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

aliases() {
  alias | grep -E ${1-.} | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort | fzf-tmux
}

envs() {
  alias | grep -E ${1-.} | \
    sed 's/^(\w+)(=)(.*)$/\%F{green}$1%f\033[m $2 $3/' | \
    fzf-tmux
}

escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    echo # newline
}

ip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

cpp () {
  rsync -WavP --human-readable --progress $1 $2
}

# get gzipped size
gz() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

# animated gifs from any video from gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 900x900\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}