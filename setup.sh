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

# Upgrade and cleanup
brew upgrade
brew cleanup

# Stow dotfiles
./stow_dotfiles.sh

# Install alacritty gruvbox theme
mkdir -p ~/.config/alacritty/themes
if [ ! -d ~/.config/alacritty/themes/.git ]; then
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

# Install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install rust via rustup
rustup update

# Update tealdeer cache
tldr --update || true
