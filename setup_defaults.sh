#!/bin/bash

# Abort the script if any command fails
set -e
# Display the commands being executed in the terminal
set -x

# set display sleep duration 30min for installing 
sudo pmset -a displaysleep 1800

# Key Input Related
defaults write -g InitialKeyRepeat -int 15                                     # Time from key press to repeat start (shorter is faster)
defaults write -g KeyRepeat -int 1                                             # Key repeat speed (shorter is faster)
defaults write com.apple.keyboard.prefs.fnState -int 0                         # Set Fn (Globe) key behavior to "Do Nothing"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # Disable automatic spell correction (e.g., prevents clippy -> clip)
defaults write NSGlobalDomain NSSpellCheckerEnabled -bool true                 # Show red underline for spelling mistakes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false   # Disable automatic conversion of "---" to "—" (em dash)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false  # Disable automatic conversion of "" to “ ” (smart quotes)
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false     # Disable automatic capitalization of the first word of a sentence
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # Disable ending with "." when period is typed twice
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false             # Disable accent character menu on key hold (e.g., é)

# Trackpad/Input Related
defaults write -g com.apple.trackpad.scaling -float 3.0 # Set trackpad cursor speed to maximum (fast)
defaults write -g com.apple.mouse.scaling -float 3.0    # Set mouse cursor speed to maximum (fast)
# Enable "Tap to click"
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable "Double-tap and hold to drag"
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
# Disable "Three-finger drag" (as it conflicts with the above)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false

# Screenshot
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture show-thumbnail -bool false

# Hotcorner
defaults write com.apple.dock wvous-tl-corner -int 11 # Launch "Launchpad" when cursor moves to top-left corner
defaults write com.apple.dock wvous-tr-corner -int 2  # Launch "Mission Control" when cursor moves to top-right corner
defaults write com.apple.dock wvous-bl-corner -int 4  # Show "Desktop" when cursor moves to bottom-left corner
defaults write com.apple.dock wvous-br-corner -int 14 # Launch "Quick Note" when cursor moves to bottom-right corner
killall Dock                                          # Restart Dock to apply hot corner settings

# Dock
defaults write com.apple.dock orientation -string "right" # Set Dock position to the right
defaults write com.apple.dock mineffect -string "scale"   # Change window minimization animation to "scale effect"
# NOTE: Run only if you want to clear the Dock
# defaults write com.apple.dock static-only -bool true            # Show only running apps in Dock (hide persistent icons)
defaults write com.apple.dock showhidden -bool true             # Show hidden app icons as translucent in Dock
defaults write com.apple.dock show-recents -bool false          # Do not show "Recent Applications" in Dock
defaults write com.apple.dock autohide -bool true &&            # Automatically hide the Dock
  defaults write com.apple.dock autohide-time-modifier -float 0 # Set Dock hide/show animation time to 0 (instant)
killall Dock                                                    # Restart Dock to apply settings

# Finder
defaults write com.apple.finder ShowPathbar -bool true                       # Show path bar at the bottom of Finder windows
defaults write com.apple.finder ShowStatusBar -bool true                     # Show status bar at the bottom of Finder windows
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true           # Show full POSIX path in Finder window title bar
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false   # Do not show warning when changing file extensions
defaults write com.apple.finder QLEnableTextSelection -bool true             # Allow text selection and copying in Quick Look windows
defaults write com.apple.finder DSDontWriteNetworkStores -bool true          # Do not create .DS_Store files on network drives
defaults write com.apple.finder AppleShowAllFiles -bool true                 # Show all files (including hidden files starting with .) in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true              # Show all file extensions (e.g., .txt)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"          # Default search scope to current folder in Finder
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true  # Expand save dialogs by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true # Expand save dialogs by default (for compatibility)
killall Finder                                                               # Restart Finder to apply settings
