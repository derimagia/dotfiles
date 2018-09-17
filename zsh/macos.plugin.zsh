[[ $OSTYPE =~ darwin ]] || return

export BROWSER='open'

alias open='() { command open ${@:-"."} }'
alias o='open'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash; sudo rm /private/var/vm/sleepimage"
alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias cask='brew cask'
alias mas='reattach-to-user-namespace mas'
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
alias wifi-ssid="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr(\$0, index(\$0, \$2))}'"
alias docker-screen="screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty"
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# quicklook
ql() {
    [[ -f $1 ]] || ink -c red -t 2 'Invalid file' | return 1
    chronic sh -c "qlmanage -p $'$1'" &!
}

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
unalias run-help; autoload run-help

if [[ -n "$ITERM_PROFILE" ]] {
    iterm2_hostname="$HOST"

    # iterm2 integration
    [[ -s $TMPPREFIX/iterm2.zsh ]] || curl -s 'https://raw.githubusercontent.com/gnachman/iterm2-website/master/source/misc/zsh_startup.in' >| $TMPPREFIX/iterm2.zsh
    source $TMPPREFIX/iterm2.zsh
}
