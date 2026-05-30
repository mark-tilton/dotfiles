#!/usr/bin/env bash
set -e

cd ~/repos/dotfiles/ || exit

# Install xcode command line tools
echo "Setting up command line tools"
xcode-select --install || true

# Install homebrew
echo "Installing homebrew"
if test ! "$(which brew)"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew update

# Install everything from the Brewfile
echo "Installing packages from Brewfile"
brew bundle --file=./Brewfile

# Install Python CLI tools
pipx install zk-graph-view || pipx upgrade zk-graph-view

# Upgrade and cleanup
brew upgrade
brew cleanup

# Stow dotfiles
./stow_dotfiles.sh

# Install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# macOS defaults
echo "Setting macOS defaults"
# Disable window open/close animations so AeroSpace can reposition immediately
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
# Reduce motion further cuts AeroSpace's animation-wait lag (takes effect after logout)
defaults write com.apple.universalaccess reduceMotion -bool true

# Rectangle window snapping — ctrl+cmd bindings, drag-to-snap disabled
rectangle_mod=1310720 # ctrl+cmd
killall Rectangle 2>/dev/null || true
defaults write com.knollsoft.Rectangle leftHalf       "{ keyCode = 4;  modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle rightHalf      "{ keyCode = 37; modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle firstTwoThirds "{ keyCode = 38; modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle lastTwoThirds  "{ keyCode = 40; modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle firstThird     "{ keyCode = 32; modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle centerThird    "{ keyCode = 34; modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle lastThird      "{ keyCode = 31; modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle maximize       "{ keyCode = 36; modifierFlags = $rectangle_mod; }"
defaults write com.knollsoft.Rectangle windowSnapping -int 0
# Inset snapped/maximized windows so the 6px JankyBorders border isn't clipped
defaults write com.knollsoft.Rectangle gapSize -float 8

# Updates that can be slow on every run — pass --skip-updates to bypass
if [[ "$*" != *--skip-updates* ]]; then
    rustup update || true
    tldr --update || true
fi
