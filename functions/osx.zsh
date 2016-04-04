#!/usr/bin/env bash

# Quicklook
function ql() {
  nullify qlmanage -p "$@"
}

function dash() {
	open "dash://$*"
}

# Switchs Java Home
function jhome () {
  export JAVA_HOME=`/usr/libexec/java_home $@`
  echo "JAVA_HOME:" $JAVA_HOME
  echo "java -version:"
  java -version
}

function mand() {
  open "dash://manpages:$1" 2>/dev/null
}

# Finder Directory
function osx-pfd() {
  osascript 2>/dev/null <<EOF
  tell application "Finder"
    return POSIX path of (target of first window as text)
  end tell
EOF
}

# Finder Selection
function osx-pds() {
  osascript 2>&1 <<EOF
  tell application "Finder" to set the_selection to selection
  if the_selection is not {}
    repeat with an_item in the_selection
      log POSIX path of (an_item as text)
    end repeat
  end if
EOF
}

function osx-rm-dir-metadata() {
  find "${@:-$PWD}" \( \
  -type f -name '.DS_Store' -o \
  -type d -name '__MACOSX' \
  \) -print0 | xargs -0 rm -rf
}

function osx-ls-download-history() {
  local db
  for db in ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*; do
    if grep -q 'LSQuarantineEvent' < <(sqlite3 "$db" .tables); then
      sqlite3 "$db" 'SELECT LSQuarantineDataURLString FROM LSQuarantineEvent'
    fi
  done
}
