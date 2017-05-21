# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white

setopt MENU_COMPLETE # Automatically select menu

# Cache
zstyle ':completion:*' cache-path "$TMPPREFIX/zcompcache"

# Completions
zstyle ':completion:*' verbose yes

# Turn on menu selection when selections do not fit on screen
zstyle ':completion:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*' group-name '' # Group based on the tag, everywhere

# Describe Options
zstyle ':completion:*:options' description yes

# Ignored Patterns (Except rm)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'

# Completion presentation styles.
zstyle ':completion:*:options' auto-description 'specify: %d'
zstyle ':completion:*:descriptions' format $'\e[32m -- %d --\e[00m'
zstyle ':completion:*:messages'     format $'\e[32m -- %d --\e[00m'
zstyle ':completion:*:warnings'     format $'\e[33m -- No matches found for %d --\e[00m'

# Case insensitive search
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle -e ':completion:*:default'      list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=0}:/${(s.:.)LS_COLORS}")' # Parial Matching
zstyle ':completion:*:commands'        list-colors '=*=32'
zstyle ':completion:*:builtins'        list-colors '=*=34'
zstyle ':completion:*:functions'       list-colors '=*=34'
zstyle ':completion:*:aliases'         list-colors '=*=34'
zstyle ':completion:*:parameters'      list-colors '=*=33'
zstyle ':completion:*:reserved-words'  list-colors '=*=31'
zstyle ':completion:*:manuals*'        list-colors '=*=36'
zstyle ':completion:*:options'         list-colors '=*=32' #'=^(-- *)=38;5;28'

zstyle ':completion:*:functions' ignored-patterns '_*' # Remove complete/hidden functions
zstyle '*' single-ignored menu # Fall back to ignored

# Don't complete uninteresting users.
zstyle ':completion:*:*:*:users' ignored-patterns '_*'

# Hostnames completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*[*?]*}%\#*}% *}
    ${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}#*[[:blank:]]}}
  )'
zstyle ':completion:*:*:*:hosts' ignored-patterns 'ip6*' 'localhost*'

zstyle ':completion:*'    completer   _expand_alias \
                                      _complete \
                                      _ignored \
                                      _approximate

# Ignore Patterns
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'

# Ignore hidden files by default
zstyle ':completion:*:(all-|other-|)files'  ignored-patterns '*/.*'
zstyle ':completion:*:(local-|)directories' ignored-patterns '*/.*'
zstyle ':completion:*:cd:*'                 ignored-patterns '*/.*'

# Speed up completion by avoiding partial globs.
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact-dirs true

# Style for cd
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories

# Style for Kill
zstyle ':completion:*:*:kill:*:processes'        list-colors '=(#b) #([0-9]#)* (*[a-z])*=32=31'
zstyle ':completion:*:*:killall:*:processes-names' list-colors '=*=32'

# Shift tab for backwards
bindkey $terminfo[kcbt] reverse-menu-complete

# Save script to load completions for kubectl
if (( $+commands[kubectl] )) {
    [[ -s $TMPPREFIX/autoload/_kubectl ]] || kubectl completion zsh >| $TMPPREFIX/autoload/_kubectl
}
