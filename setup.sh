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

# Updates that can be slow on every run — pass --skip-updates to bypass
if [[ "$*" != *--skip-updates* ]]; then
    rustup update || true
    tldr --update || true
fi
