# Aliases
alias re='. ~/.zshrc'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias fs='stat -c "%s Bytes"' # File Size
alias la='ls -l'
alias l='exa -l'
alias map="xargs -n1"
alias dottime='time zsh -ic exit';
alias man="mangle" # This should be a drop-in change, let's me do "man ls -A"
alias mou="open /Applications/Mou.app" # Mou!
alias tail='multitail';
alias top='htop';
alias editvar='vared';

# Url functions
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'

# Alias-Specific Functions
_expand-aliases() {
    unset 'functions[_expand-aliases-temp]'
    functions [ _expand - aliases - temp ] = $BUFFER
    (( $ + functions [ _expand - aliases - temp ] )) &&
    BUFFER=${functions[_expand-aliases]#$'\t'} &&
    CURSOR=$#BUFFER
}
zle -N expand-aliases && bindkey '\ee' _expand-aliases

aliases() {
    alias | grep -E ${1-.} | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort | fzf-tmux
}

