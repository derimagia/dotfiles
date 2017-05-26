[[ $OSTYPE =~ darwin ]] || return

export BROWSER='open -a "Google Chrome"'

alias o="open"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash; sudo rm /private/var/vm/sleepimage"
alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias cask='brew cask'
alias app='open -a'
alias mas='reattach-to-user-namespace mas'
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
alias wifi-ssid="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr(\$0, index(\$0, \$2))}'"
alias docker-screen="screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty"
alias ql='qlmanage -p'

# dash
dash() {
  open "dash://$*"
}

# dash man
mand() {
    dash "manpages:$1" 2>/dev/null
}

# finder Directory
pfd() {
    osascript 2>/dev/null <<EOF
    tell application "Finder"
        return POSIX path of (target of first window as text)
    end tell
EOF
}

# Finder Selection
pds() {
    osascript 2>&1 <<EOF
    tell application "Finder" to set the_selection to selection
    if the_selection is not {}
        repeat with an_item in the_selection
            log POSIX path of (an_item as text)
        end repeat
    end if
EOF
}

# print download history
osx-ls-download-history() {
    local db
    for db in ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*; do
        if grep -q 'LSQuarantineEvent' < <(sqlite3 "$db" .tables); then
            sqlite3 "$db" 'SELECT LSQuarantineDataURLString FROM LSQuarantineEvent'
        fi
    done
}

# find all launchctl scripts
osx-find-launchctl () {
    LaunchctlPATHS=( \
        ~/Library/LaunchAgents \
        /Library/LaunchAgents \
        /Library/LaunchDaemons \
        /System/Library/LaunchAgents \
        /System/Library/LaunchDaemons \
    )

    for curPATH in "${LaunchctlPATHS[@]}"; do
        sudo grep -i -r "$curPATH" -e "$1"
    done
}

# Fix Help
unalias run-help 2>/dev/null
autoload run-help
HELPDIR=$HOMEBREW_PREFIX/share/zsh/help
alias help=run-help

# iterm2 integration
[[ -s $TMPPREFIX/iterm2.zsh ]] || curl -s 'https://iterm2.com/misc/zsh_startup.in' >| $TMPPREFIX/iterm2.zsh
source $TMPPREFIX/iterm2.zsh
