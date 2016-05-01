# Aliases
alias re='. ~/.zshrc'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias fs='stat -c "%s Bytes"' # File Size
alias la='ls -l'
alias l='k -Ah'
alias map="xargs -n1"
alias time="command time" # I never want the builtin
alias man="mangle" # This should be a drop-in change, let's me do "man ls -A"
alias dottime="/usr/bin/time zsh -i -c exit"
alias '?'='echo $?'
alias mou="open /Applications/Mou.app" # Mou!
alias tail='multitail';
alias top='htop';
alias time.='/usr/bin/time zsh -i -c exit';
alias editvar='vared';

# Alias-Specific Functions
_expand-aliases() {
    unset 'functions[_expand-aliases-temp]'
    functions[_expand-aliases-temp]=$BUFFER
    (($+functions[_expand-aliases-temp])) &&
    BUFFER=${functions[_expand-aliases]#$'\t'} &&
    CURSOR=$#BUFFER
}
zle -N expand-aliases && bindkey '^e' _expand-aliases # Option + e = expand

aliases() {
  alias | grep -E ${1-.} | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort | fzf-tmux
}

