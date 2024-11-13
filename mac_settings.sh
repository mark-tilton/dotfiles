# Only show active items on the dock
defaults write com.apple.dock static-only -bool true

# Autohide the dock
defaults write com.apple.dock "autohide" -bool "true"

killall Dock

#Source: https://github.com/rusty1s/dotfiles/blob/master/macos/defaults.sh

# Set fast key repeat
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Disable the "Are you sure you want to open this application?" dialog.
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable "natural" scrolling.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Text correction
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false     # Disable automatic capitalization.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # Disable peroid substitution.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false  # Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false   # Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false     # Disable automatic capitalization.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false     # Disable text-completion.

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true                # Show hidden files.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true             # Show all file extensions.
defaults write com.apple.finder FXEnableExtensionsChangeWarning -bool false # Disable file extension change warning.
defaults write com.apple.finder ShowStatusBar -bool true                    # Show status bar.
defaults write com.apple.finder ShowPathbar -bool true                      # Show path bar.
defaults write com.apple.finder ShowRecentTags -bool false                  # Hide tags in sidebar.
defaults write com.apple.finder QuitMenuItem -bool true                     # Allow quitting finder via ⌘ + Q.
defaults write com.apple.finder SidebarWidth -int 175                       # Greater sidebar width.
defaults write com.apple.finder WarnOnEmptyTrash -bool false                # No warning before emptying trash.

# Use plain text mode for new TextEdit documents.
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Prevent Photos from opening automatically when devices are plugged in.
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Stop iTunes from responding to the keyboard media keys.
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null
