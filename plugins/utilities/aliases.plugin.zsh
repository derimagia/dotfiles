# Aliases
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias fs='stat -c "%s Bytes"' # File Size
alias l='exa -l'
alias map="xargs -n1"
alias dottime='time zsh -ic exit';
alias mou="open /Applications/Mou.app" # Mou!
alias tail='multitail';
alias top='htop';
alias editvar='vared';

alias -g G="| grep -i --"
alias -g P='2>&1 | $PAGER'

# Suffix Aliases
alias -s Dockerfile="docker build - < "
alias -s htm="$BROWSER"
alias -s html="$BROWSER"
alias -s jar="java -jar"
alias -s war="java -jar"

# Url functions
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
