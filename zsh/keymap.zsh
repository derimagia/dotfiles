bindkey -v
autoload -U edit-command-line
zle -N edit-command-line

bindkey -M vicmd 'v' edit-command-line
bindkey -M vicmd ':' execute-named-cmd

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

function globalias() {
  if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
   zle _expand_alias
   zle expand-word
  fi
  zle self-insert
}

zle -N globalias

bindkey ' ' globalias
bindkey '^ ' magic-space           # control-space to bypass completion
bindkey -M isearch ' ' magic-space # normal space during searche
