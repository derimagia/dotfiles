# Aliases
alias fs='stat -c "%s Bytes"' # File Size

# l script +
# human readable dates, add "/" to directory, show almost all (aka not "." and "..)
alias l='l -hpA'
alias map="xargs -n1"
alias dottime='time zsh -ic true';
alias cddot="cd $DOTFILES"
alias editvar='vared'
alias v="vim"
alias ffs='sudo $(fc -ln -1)'
alias ag='ag -f --hidden'
alias ccat='vimcat'
alias mmv='noglob zmv -W'
alias dk='desk .'

alias -g G="| grep -i --"
alias -g P='2>&1 | $PAGER'

# Suffix Aliases
alias -s htm="$BROWSER"
alias -s html="$BROWSER"
alias -s yaml="ccat"
alias -s yml="ccat"
alias -s json="jq ."
alias -s xml="ccat"
alias -s py="python"
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
        return 1
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
    ink -c blue '$#'
    print -l $#
    ink -c blue '$*'
    print -l $*
    ink -c blue '$@'
    print -l $@
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

# Print opened connections, filtered by known applications.
lsofopen() {
    # 2BUA8C4S2 = 1password
    local ignore=(Google Dropbox Slack Mail 2BUA8C4S2)
    lsof -nPi TCP | grep -v "^${(j:\|:)ignore}"
}

# Scan incoming traffic.
sniff() {
	local device='en0'
	local port=80

	case "$#" in
		1) device="$1";;
		2) device="$1"
		   port="$2";;
		*) ;;
	esac

	sudo ngrep -d ${device} -t '^(GET|POST) ' "tcp and port ${port}"
}

# Create a data URL from a file
dataurl() {
	local mimeType=`file -b --mime-type "$1"`

	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(base64 -w 0 "$1")"
}

# Reads a link until  can't anymore.
readtrail () {
    local the_path="$1"
    [[ -L $the_path ]] || return

    # If there's no link we're at the top
    if [[ -z $the_link ]]; then
        echo $the_path
    fi

    local the_link=${the_path:A}
    if [[ "$the_path" != "$the_link" ]]; then
        echo $the_link
        readtrail $the_link
    fi
}
