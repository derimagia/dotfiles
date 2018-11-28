# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white

# Automatically select menu
setopt MENU_COMPLETE

# For mid-word completions, the cursor is moved to the end of the word
setopt ALWAYS_TO_END

# Don't beep on an ambiguous completion.
unsetopt LIST_BEEP

zstyle ':completion:*' single-ignored menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*' group-name '' # Group based on the tag, everywhere
zstyle ':completion:*' verbose yes

# cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:s*' cache-path "$TMPPREFIX/zcompcache"

# Completion presentation styles.
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# colors
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:commands'        list-colors '=*=32'
zstyle ':completion:*:builtins'        list-colors '=*=34'
zstyle ':completion:*:functions'       list-colors '=*=34'
zstyle ':completion:*:aliases'         list-colors '=*=34'
zstyle ':completion:*:parameters'      list-colors '=*=33'
zstyle ':completion:*:reserved-words'  list-colors '=*=31'
zstyle ':completion:*:manuals*'        list-colors '=*=36'
zstyle ':completion:*:options'         list-colors '=*=32'

# insensitive search
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# hostnames completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
	${${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*[*?]*}%\#*}% *}
	${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}#*[[:blank:]]}})'
zstyle ':completion:*:*:*:hosts' ignored-patterns 'ip6*' 'localhost*'

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# ignore patterns
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'
zstyle ':completion:*:*:*:users' ignored-patterns '_*'

# speed up completion by avoiding partial globs
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact-dirs true

# cd / directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'expand'

# kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)* (*[a-z])*=32=31'
zstyle ':completion:*:*:killall:*:processes-names' list-colors '=*=32'

# man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# shift+tab for backwards
bindkey $terminfo[kcbt] reverse-menu-complete

# Allow ctrl+space to expand aliases/words
expand-all-aliases() {
   zle _expand_alias
   zle expand-word
}
zle -N expand-all-aliases

