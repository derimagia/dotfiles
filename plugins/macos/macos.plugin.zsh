[[ $OSTYPE =~ darwin ]] || return

# Brew-wrap

export BROWSER="'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'"

alias o="open"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash; sudo rm /private/var/vm/sleepimage"
alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias cask='brew cask'
alias mansearch='apropos' # I got to learn the name
alias mas='reattach-to-user-namespace mas'

# Quicklook
ql() {
  nullify qlmanage -p "$@"
}

dash() {
  open "dash://$*"
}

# Switches Java Home
jhome () {
  export JAVA_HOME=`/usr/libexec/java_home $@`
  echo "JAVA_HOME:" $JAVA_HOME
  echo "java -version:"
  java -version
}

mand() {
  open "dash://manpages:$1" 2>/dev/null
}

# Finder Directory
osx-pfd() {
  osascript 2>/dev/null <<EOF
  tell application "Finder"
    return POSIX path of (target of first window as text)
  end tell
EOF
}

# Finder Selection
osx-pds() {
  osascript 2>&1 <<EOF
  tell application "Finder" to set the_selection to selection
  if the_selection is not {}
    repeat with an_item in the_selection
      log POSIX path of (an_item as text)
    end repeat
  end if
EOF
}

osx-rm-dir-metadata() {
  find "${@:-$PWD}" \( \
  -type f -name '.DS_Store' -o \
  -type d -name '__MACOSX' \
  \) -print0 | xargs -0 rm -rf
}

osx-ls-download-history() {
  local db
  for db in ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*; do
    if grep -q 'LSQuarantineEvent' < <(sqlite3 "$db" .tables); then
      sqlite3 "$db" 'SELECT LSQuarantineDataURLString FROM LSQuarantineEvent'
    fi
  done
}

osx-find-launchctl () {
    LaunchctlPATHS=( \
        ~/Library/LaunchAgents \
        /Library/LaunchAgents \
        /Library/LaunchDaemons \
        /System/Library/LaunchAgents \
        /System/Library/LaunchDaemons \
    )

    for curPATH in "${LaunchctlPATHS[@]}"
    do
        grep -r "$curPATH" -e "$1"
    done
    return 0;
}

if [[ -x "/usr/libexec/java_home" ]]; then
    # Determine java home
    async_start_worker java_home_osx 2>/dev/null && {
        async_register_callback java_home_osx _detect_java_home_osx_callback
        async_job java_home_osx /usr/libexec/java_home

        _detect_java_home_osx_callback() {
            export JAVA_HOME="$3"
            async_stop_worker java_home_osx
        }
    }
fi


# Fix Help
unalias run-help 2>/dev/null
autoload run-help
HELPDIR=$HOMEBREW_PREFIX/share/zsh/help
alias help=run-help
