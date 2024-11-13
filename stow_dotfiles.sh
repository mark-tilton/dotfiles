# Set up subdirectories separately
stow .config -t ~/.config -v

# Set up symlinks for dotfiles
stow . -t ~ -v
