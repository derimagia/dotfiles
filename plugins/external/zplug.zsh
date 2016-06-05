ZPLUG_HOME=$HOME/.zplug
{ [[ -d $ZPLUG_HOME ]] || git clone https://github.com/zplug/zplug $ZPLUG_HOME }; source $ZPLUG_HOME/init.zsh

if [[ -f $ZPLUG_HOME/.cache ]]; then
    # Zplug Load is a bit slow, just load the cache directly
    is_verbose=false
    source $ZPLUG_HOME/.cache;
    unset is_verbose
    return;
fi

zplugs=() # Reset zplugs

# Use zplug for binaries in local files
zplug $DOTFILES/plugins, as:command, use:'**/bin/*', from:local

zplug mafredri/zsh-async, use:"-" # Just download the repo
zplug derimagia/base16-builder, use:output/shell/base16-oceanicnext.dark.sh
zplug junegunn/fzf, use:shell/completion.zsh, if:"($+commands[fzf])"
zplug $HOMEBREW_PREFIX/etc/brew-wrap, from:local, if:"($+commands[brew])"
zplug ogham/exa, from:gh-r, as:command
zplug MarianoGappa/jira-cli, use:jira.sh

# Themes
zplug sindresorhus/pure

# Packages
zplug trapd00r/LS_COLORS
zplug zsh-users/zsh-completions, use:src
zplug zsh-users/zsh-history-substring-search
zplug zsh-users/zsh-autosuggestions
zplug derimagia/zsh-syntax-highlighting, nice:10 # Change back to zsh-users/zsh-syntax-highlighting when it plays well with zsh-autosuggest

# Check in Background
{zplug check || zplug install}&!

zplug load
