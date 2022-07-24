# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html

setopt COMBINING_CHARS       # Combine zero-length punctuation characters (accents) with the base character.

unsetopt MAIL_WARNING        # Don't print a warning message if a mail file has been accessed.

setopt MULTIOS               # Perform implicit tees or cats when multiple redirections are attempted.
setopt AUTO_CD               # Perform cd command to directory automatically.

setopt EXTENDED_HISTORY      # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.
setopt SHARE_HISTORY         # This option both imports new commands from the history file
setopt HIST_IGNORE_DUPS      # Do not enter command lines into the history list if they are duplicates of the previous event.
setopt INTERACTIVE_COMMENTS  # Allow comments even in interactive shells.

setopt MAGIC_EQUAL_SUBST     # All unquoted arguments of the form ‘anything=expression’ appearing after the command name have filename expansion (that is, where expression has a leading ‘~’ or ‘=’).
setopt SHORT_LOOPS           # Allow the short forms of for, repeat, select, if, and function constructs.

# ZSH Variables
HISTFILE="$XDG_DATA_HOME/zsh/history" HISTSIZE=100000 SAVEHIST=100000

# Reset key bindings
bindkey -e

# Autoload local files
autoload -Uz async clone compress-bench prompt_pure_setup sysinfo _whi whi zre
fpath+=("$ZDOTDIR"/autoload)
path=("$ZDOTDIR"/bin ~/.local/bin $path)

source "$ZDOTDIR/completion.zsh"

# Autoquote pasted URLs
autoload -Uz bracketed-paste-url-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-url-magic
zle -N self-insert url-quote-magic

## Packages

[[ -e "$ZDOTDIR/.antidote" ]] || git clone https://github.com/mattmc3/antidote.git "$ZDOTDIR/.antidote"

. "$ZDOTDIR/.antidote/antidote.zsh"

# Packaged
if [[ ! -f "$TMPPREFIX/zsh-plugins.sh" ]]; then
	{
		# Packaged
		local zsh_plugins=(
			paulirish/git-open
			zsh-users/zsh-completions
			zsh-users/zsh-autosuggestions
			zsh-users/zsh-history-substring-search
			zdharma-continuum/history-search-multi-word
			zsh-users/zsh-syntax-highlighting
		)

		antidote init
		echo ${(F)zsh_plugins} | antidote bundle
	} | > "$TMPPREFIX/zsh-plugins.sh"
fi
source "$TMPPREFIX/zsh-plugins.sh"

# choose the most recent match whose preceding history item matches the most recently executed command
typeset -ga ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

# Fixes autosuggest not clearing properly when pasting
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=magenta'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

if [[ "$TERM" != 'dumb' ]]; then
	# Setup Prompt
	autoload -Uz promptinit && promptinit
	prompt 'pure'

	prompt_pure_colors_default[path]='magenta'

	# Setup colors
	autoload -Uz colors && colors

	if [[ ! -f "$TMPPREFIX/colors.sh" ]]; then
		dircolors -b "$XDG_CONFIG_HOME/dircolors" > "$TMPPREFIX/colors.sh"
	fi
	source "$TMPPREFIX/colors.sh"

	typeset -ga ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

	typeset -gA ZSH_HIGHLIGHT_STYLES
	ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan,underline'
	ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
	ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
	# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=none'
	# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=none'
	# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=none'
	# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=none'
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=green,underline'
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=green,underline'
	ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
	ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=green,underline'
	ZSH_HIGHLIGHT_STYLES[comment]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
fi

# Keybindings
bindkey "$terminfo[khome]"   beginning-of-line               # [Home]
bindkey "$terminfo[kend]"    end-of-line                     # [End]
bindkey "$terminfo[kich1]"   overwrite-mode                  # [Insert]
bindkey "$terminfo[kdch1]"   delete-char                     # [Delete]

bindkey "$terminfo[kpp]"     up-line-or-history              # [Page Up]
bindkey "$terminfo[knp]"     down-line-or-history            # [Page Down]

bindkey '^[[A'               history-substring-search-up     # [UpArrow]
bindkey '^[[B'               history-substring-search-down   # [DownArrow]

bindkey "$terminfo[kcbt]"    reverse-menu-complete           # [Shift-Tab] - Move through complete menu backwards

bindkey '^[[1;5C'            forward-word                    # [Ctrl-RightArrow] - Move forward one
bindkey '^[[1;5D'            backward-word                   # [Ctrl-LeftArrow] - Move back one word

# bindkey '\ew' kill-region                                  # [Esc-w] - Kill from the cursor to the mark

# Match bracket.
# bindkey -M emacs "\C-X \C-]" vi-match-bracket

# Edit command in an external editor.
# bindkey '^xe'  edit-command-line                     # [Ctrl-x e] - Edit command line
# bindkey '^x^e' edit-command-line                     # [Ctrl-x Ctrl-e] - Edit command line

source "$ZDOTDIR/aliases.zsh"

## Local
path=("$ZDOTDIR"/local/bin $path)
[[ -f "$ZDOTDIR"/.zlocalrc ]] && source "$ZDOTDIR"/.zlocalrc

(( ${+ZPROFILING} )) && { unset ZPROFILING && zprof }
