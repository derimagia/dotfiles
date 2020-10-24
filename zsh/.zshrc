setopt MULTIOS # Perform implicit tees or cats when multiple redirections are attempted.
setopt AUTO_CD # Perform cd command to directory automatically.# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html

setopt EXTENDED_HISTORY # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.
setopt SHARE_HISTORY # This option both imports new commands from the history file
setopt HIST_IGNORE_DUPS # Do not enter command lines into the history list if they are duplicates of the previous event.
setopt INTERACTIVE_COMMENTS # Allow comments even in interactive shells.

setopt MAGIC_EQUAL_SUBST # All unquoted arguments of the form ‘anything=expression’ appearing after the command name have filename expansion (that is, where expression has a leading ‘~’ or ‘=’).
setopt SHORT_LOOPS # Allow the short forms of for, repeat, select, if, and function constructs.
setopt KSH_OPTION_PRINT # Alters the way options settings are printed: instead of separate lists of set and unset options, all options are shown, marked ‘on’ if they are in the non-default state, ‘off’ otherwise.

# Autoload needed functions
autoload -Uz compinit

# Reset key bindings
bindkey -e

# ZSH Variables
HISTFILE="$XDG_DATA_HOME/zsh/history" HISTSIZE=100000 SAVEHIST=100000

## Custom Packages

# Autoload files
autoload -Uz "$ZDOTDIR"/autoload/*(-.N:t)
fpath+=("$ZDOTDIR"/autoload)
path=("$ZDOTDIR"/bin $path)

for plugin_file ("$ZDOTDIR"/*.plugin.zsh) source "$plugin_file"
unset plugin_file

typeset -ga ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=1
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=magenta'
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

bindkey '^[[A' history-substring-search-up          # [UpArrow] - Sourced after syntax-highlighting
bindkey '^[[B' history-substring-search-down        # [DownArrow]

bindkey '^[[1;5C' forward-word                      # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                     # [Ctrl-LeftArrow] - move backward one word

bindkey "${terminfo[kcbt]}"  reverse-menu-complete  # [Shift-Tab] - Reverse select in completion
bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line

bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - Delete

bindkey '\ew' kill-region                           # [Esc-w] - Kill from the cursor to the mark

## Local
path=("$ZDOTDIR"/local/bin $path)
[[ -f "$ZDOTDIR"/.zlocalrc ]] && source "$ZDOTDIR"/.zlocalrc

compinit -C

(( $PROFILING )) && zprof
