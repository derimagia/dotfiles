#!/usr/bin/env zsh
alias androidem='emulator @Nexus_6P_API_23'
alias androidemproxy='emulator @Nexus_6P_API_23 -http-proxy http://`ipconfig getifaddr en0`:8888'

# Android SDK Tools
PATH="$HOME/Library/Android/sdk/tools:$PATH"


# Run an Android Activity
adb-run() {
    adb shell monkey -p `cat .identifier` -c android.intent.category.LAUNCHER 1
}
