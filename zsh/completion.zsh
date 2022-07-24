# Autoload needed functions
autoload -Uz compinit

setopt ALWAYS_TO_END           # Move cursor to the end of a completed word.
setopt AUTO_MENU               # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH        # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD        # Do completion from both ends of the word.
setopt EXTENDED_GLOB           # Needed for file modification glob modifiers

# unsetopt LIST_BEEP             # Don't beep on an ambiguous completion.
unsetopt MENU_COMPLETE         # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL          # Disable start/stop characters in shell editor.

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours
autoload -Uz compinit
_comp_path="$TMPPREFIX/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
  # -C (skip function check) implies -i (skip security check).
  compinit -C -d "$_comp_path"
else
  mkdir -p "$_comp_path:h"
  compinit -i -d "$_comp_path"
  # Keep $_comp_path younger than cache time even if it isn't regenerated.
  touch "$_comp_path"
fi
unset _comp_path

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''   # Group based on the tag, everywhere
zstyle ':completion:*' verbose yes

# cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$TMPPREFIX/zcompcache"

# Completion presentation styles.
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

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

# Case insensitive search
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# hostnames completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
	${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
	${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
	${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
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
