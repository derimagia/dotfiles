# Aliases
alias fs='stat -c "%s Bytes"' # File Size
alias ll='ls -lahpA'
alias map="xargs -n1"
alias dottime='time zsh -ic true';
alias mou="open /Applications/Mou.app" # Mou!
alias editvar='vared'
alias v="vim"
alias dk='desk .'
alias ffs='sudo $(fc -ln -1)'
alias ag='ag -f --hidden'
alias ccat='ccat --bg=dark'

alias -g G="| grep -i --"
alias -g P='2>&1 | $PAGER'

# Suffix Aliases
alias -s htm="$BROWSER"
alias -s html="$BROWSER"
alias -s py=python
alias -s jar="java -jar"
alias -s war="java -jar"

# Url functions
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
alias html2text='w3m -dump -T text/html'

# Create a new directory and enter it
take() {
    mkdir -p "$1" && cd "$1"
}

# z is the new j? I guess?
z() {
    text="$@"
    if [[ -z "$text" ]]; then
        # Print with score
        cd "$(fasd -d "$text" | fzf-tmux | awk '{print $2}')"
        return
    fi

    directory=$(fasd -ld "$text" | head -n1)
    if [[ -n $directory ]]; then
        cd "$directory"
    else
        ink -c red -t 2 'No Directory found'
    fi
}

f() {
    fasd -f "$1" | fzf-tmux --select-1 | awk '{print $2}'
}

# All the dig info
digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

aliases() {
    alias | grep -E ${1-.} | \
        ccat | \
        fzf-tmux
}

ip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

cpp() {
    rsync -WavP --human-readable --progress $1 $2
}

# get gzipped size
gz() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

# direct it all to /dev/null
nullify() {
    "$@" >/dev/null 2>&1
}

args() {
    print $# $*
}

manzsh() {
  man zshbuiltins | less -XF -p "^ *$@"
}

manopt() {
  local program="$1"
  shift
  man $program | less -XF -p "^ *$@"
}

# UTF-8-encode a string of Unicode symbols
escape() {
	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

# Get a character’s Unicode code point
codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

# Watch and print out fs changes. Defaults to current directory
watchfs() {
    watchargs=$*
    if [[ -z $watchargs ]]; then
        watchargs='.'
    fi

    sudo watchman-wait -m 0 $watchargs
}
