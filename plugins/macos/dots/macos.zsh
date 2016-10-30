#!/usr/bin/env zsh

[[ $OSTYPE =~ darwin ]] || exit 34

PLUGIN_DIR="${0:h}/../"
PLUGIN_DIR=${PLUGIN_DIR:a}

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


function CFPreferencesAppSynchronize() {
    /usr/bin/python - <<END
from Foundation import CFPreferencesAppSynchronize
CFPreferencesAppSynchronize('$1')
END
}


# ==============================================
# Global and NSGlobalDomain
# ==============================================
ink -l -c green -- " Setting NSGlobalDomain Preferences"

# Show the ~/Library directory
chflags nohidden "${HOME}/Library"

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Double-click a window's title bar to minimize
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1

# How long it takes to start repeating
defaults write NSGlobalDomain InitialKeyRepeat -int 20

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Menu bar: hide the Time Machine, Volume, and User icons
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
	defaults write "${domain}" dontAutoLoad -array \
		"/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
		"/System/Library/CoreServices/Menu Extras/User.menu"
done

defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Displays.menu" \
	"/System/Library/CoreServices/Menu Extras/Volume.menu" \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# ==============================================
# Finder
# ==============================================
ink -l -c green -- " Setting Finder Preferences"

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

CFPreferencesAppSynchronize "com.apple.finder"

# ==============================================
# Screen Saver
# ==============================================
ink -l -c green -- " Setting Screen Saver Preferences"

# Ask for password after 5 seconds
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# ==============================================
# Dock
# ==============================================
ink -l -c green -- " Setting Dock Preferences"

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 64

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by application in Mission Control (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Make Dock more transparent
defaults write com.apple.dock hide-mirror -bool true


# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom Right screen corner
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

CFPreferencesAppSynchronize "com.apple.dock"

# ==============================================
# Screenshots and Screensaver
# ==============================================
ink -l -c green -- " Setting Screenshot and Screensaver Preferences"

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

CFPreferencesAppSynchronize "com.apple.screencapture"

# ==============================================
# Mouse and Keyboard
# ==============================================
ink -l -c green -- " Setting Mouse and Keyboard Preferences"

# Set scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Secondary click = Right Click
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Scrolling
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseVerticalScroll -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseMomentumScroll -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseHorizontalScroll -int 1

# ==============================================
# Trackpad
# ==============================================
ink -l -c green -- " Setting Trackpad Preferences"

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Tap with two fingers to emulate right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Enable three finger tap (look up)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2

# Disable three finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false

# Rotate
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true

# Notification Center
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

# Swipe between pages with two fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true

# Swipe between full-screen apps
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2

defaults write com.apple.dock showMissionControlGestureEnabled -bool true
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.dock showDesktopGestureEnabled -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool true

# ==============================================
# Activity Monitor
# ==============================================
ink -l -c green -- " Setting Activity Monitor Preferences"

# Show main window on launch
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Dock icon = CPU Usage
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Select the Network tab
defaults write com.apple.ActivityMonitor SelectedTab -int 4

CFPreferencesAppSynchronize "com.apple.ActivityMonitor"

# ==============================================
# Contacts (Address Book)
# ==============================================
ink -l -c green -- " Setting Contacts Preferences"

# Enable the debug menu in Address Book
defaults write com.apple.addressbook ABShowDebugMenu -bool true

# Address format
defaults write com.apple.AddressBook ABDefaultAddressCountryCode -string "us"

# Display format "Last, First"
defaults write com.apple.AddressBook ABNameDisplay -int 1

# Sort by last name
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingLastName sortingFirstName"

CFPreferencesAppSynchronize "com.apple.AddressBook"

# ==============================================
# Calendar (iCal)
# ==============================================
ink -l -c green -- " Setting Calendar Preferences"

# Show week numbers (10.8 only)
defaults write com.apple.iCal "Show Week Numbers" -bool true

# Show 7 days
defaults write com.apple.iCal "n days of week" -int 7

# Week starts on monday
defaults write com.apple.iCal "first day of week" -int 1

# Show event times
defaults write com.apple.iCal "Show time in Month View" -bool true

CFPreferencesAppSynchronize "com.apple.iCal"

# ==============================================
# Disable CD & DVD actions
# ==============================================
ink -l -c green -- " Setting CD & DVD Preferences"

# Disable blank CD automatic action.
defaults write com.apple.digihub com.apple.digihub.blank.cd.appeared -dict action 1

# Disable music CD automatic action.
defaults write com.apple.digihub com.apple.digihub.cd.music.appeared -dict action 1

# Disable picture CD automatic action.
defaults write com.apple.digihub com.apple.digihub.cd.picture.appeared -dict action 1

# Disable blank DVD automatic action.
defaults write com.apple.digihub com.apple.digihub.blank.dvd.appeared -dict action 1

# Disable video DVD automatic action.
defaults write com.apple.digihub com.apple.digihub.dvd.video.appeared -dict action 1

CFPreferencesAppSynchronize "com.apple.digihub"

# ==============================================
# Archive Utility
# ==============================================
ink -l -c green -- " Setting Archive Utility Preferences"

# Move archives to trash after extraction
defaults write com.apple.archiveutility "dearchive-move-after" -string "~/.Trash"

# Don't reveal extracted items
defaults write com.apple.archiveutility "dearchive-reveal-after" -bool false

CFPreferencesAppSynchronize "com.apple.archiveutility"

# ==============================================
# Xcode
# ==============================================
ink -l -c green -- " Setting Xcode Preferences"

# Show tab bar
defaults write com.apple.dt.Xcode AlwaysShowTabBar -bool true

CFPreferencesAppSynchronize "com.apple.dt.Xcode"

# ==============================================
# Safari & WebKit                                                             #
# ==============================================
ink -l -c green -- " Setting Safari Preferences"

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Command-clicking a link creates tabs
defaults write com.apple.Safari CommandClickMakesTabs -bool true

CFPreferencesAppSynchronize "com.apple.Safari"

# ==============================================
# Spotlight                                                                   #
# ==============================================
ink -l -c green -- " Setting Spotlight Preferences"

# Hide Spotlight tray-icon (and subsequent helper)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# ==============================================
# Terminal
# ==============================================
ink -l -c green -- " Setting Terminal Preferences"

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

CFPreferencesAppSynchronize "com.apple.terminal"

# ==============================================
# Time Machine                                                                #
# ==============================================
ink -l -c green -- " Setting Time Machine Preferences"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

CFPreferencesAppSynchronize "com.apple.TimeMachine"

# ==============================================
# Dashboard
# ==============================================
ink -l -c green -- " Setting Dashboard Preferences"

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
defaults write com.apple.dashboard devmode -bool true

CFPreferencesAppSynchronize "com.apple.dashboard"

# ==============================================
# TextEdit
# ==============================================
ink -l -c green -- " Setting TextEdit Preferences"

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

CFPreferencesAppSynchronize "com.apple.TextEdit"

# ==============================================
# Disk Utility
# ==============================================
ink -l -c green -- " Setting Disk Utility Preferences"

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

CFPreferencesAppSynchronize "com.apple.DiskUtility"

# ==============================================
# Mac App Store                                                               #
# ==============================================
ink -l -c green -- " Setting Mac App Store Preferences"

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

CFPreferencesAppSynchronize "com.apple.appstore"

# ==============================================
# Messages                                                                    #
# ==============================================
ink -l -c green -- " Setting Messages Preferences"

# Disable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

CFPreferencesAppSynchronize "com.apple.messageshelper"

# ==============================================
# Alfred
# ==============================================
ink -l -c green -- " Setting Alfred Preferences"

# Sync Directory
defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder -string '~/Library/Mobile Documents/com~apple~CloudDocs/Alfred'

CFPreferencesAppSynchronize "com.runningwithcrayons.Alfred-Preferences-3"

# ==============================================
# BetterTouchTool
# ==============================================
ink -l -c green -- " Setting BetterTouchTool Preferences"

# Sync Directory
defaults write com.hegenberg.BetterTouchTool windowSnappingEnabled -bool true

# Remove Status Bar Icon
defaults write com.hegenberg.BetterTouchTool showicon -bool false

CFPreferencesAppSynchronize "com.hegenberg.BetterTouchTool"

# ==============================================
# TotalFinder
# ==============================================
ink -l -c green -- " Setting TotalFinder Preferences"

# Color in Sidebar
defaults write com.binaryage.totalfinder TotalFinderColorfulSidebarEnabled -bool true

# Show Dock Progress Bar
defaults write com.binaryage.totalfinder TotalFinderShowDockProgressBar -bool true

# Remove from Status Bar
defaults write com.binaryage.totalfinder TotalFinderShowStatusItem -bool false

# Allow Path Copying
defaults write com.binaryage.totalfinder TotalFinderCopyPathMenuEnabled -bool true

# Allow Cut and Paste
defaults write com.binaryage.totalfinder TotalFinderCutAndPasteShowContextMenuButtons -bool true

CFPreferencesAppSynchronize "com.binaryage.totalfinder"

# ==============================================
# iTerm2
# ==============================================
ink -l -c green -- " Setting iTerm2 Preferences"

# Preference Folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string $PLUGIN_DIR/etc

# Experimental!
defaults write com.googlecode.iterm2.plist ExperimentalOptimizationsEnabled -bool true

CFPreferencesAppSynchronize "com.googlecode.iterm2"

# ==============================================
# SourceTree
# ==============================================
ink -l -c green -- " Setting SourceTree Preferences"

# Allow Force Push
defaults write com.torusknot.SourceTreeNotMAS allowForcePush -bool true

# Analytics
defaults write com.torusknot.SourceTreeNotMAS analyticsHasAgreed -bool false

# Don't ask to create bookmarks on opening repo
defaults write com.torusknot.SourceTreeNotMAS createBookmarksOnOpenRepo -bool false

CFPreferencesAppSynchronize "com.torusknot.SourceTreeNotMAS"

# ==============================================
# Karabiner
# ==============================================
local karabiner_cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner
if [[ -x karabiner_cli ]]; then
    ink -l -c green -- " Setting Karabiner Preferences"
    $karabiner_cli set remap.fnletter_to_ctrlletter2 1
fi

if [[ ! -f ~/Library/Fonts/FuraMono-Regular.otf ]]; then
  # commit c232226d395b6c067a4c9ccd65a6193ac3d7ffef, don't use in url to be notified if it changes
  ink -l -c green -- " Downloading FuraMono Regular"
  wget -O ~/Library/Fonts/FuraMono-Regular.otf \
    'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20for%20Powerline%20Nerd%20Font%20Complete.otf'
fi

# ==============================================
# Kill affected applications
# ==============================================

function killallApps() {
    killall "Finder" > /dev/null 2>&1
    killall "SystemUIServer" > /dev/null 2>&1
    killall "Dock" > /dev/null 2>&1

    appsToKill=(
	    "Activity Monitor"
	    "Calendar"
	    "Contacts"
	    "Dashboard"
	    "Disk Utility"
	    "Safari"
	    "System Preferences"
	    "Xcode"
    )

    for app in "${appsToKill[@]}"
    do
        killall "${app}" > /dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            # We just killed an app so restart it
            open -a "${app}"
        fi
    done

    ink -l -c green -- " Note that some of these changes require a logout/restart to take effect."
}

exit 0
