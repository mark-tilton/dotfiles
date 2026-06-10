# Dotfiles

## Initial installation
To set up a fresh machine, all that should be needed is to run the setup script `./setup.sh`. It installs everything declared in the `Brewfile` via `brew bundle` and then stows the dotfiles in `home/`.

Preferred macOS settings can be set using `./mac_settings.sh` (also run by `setup.sh`).

## Apps
All CLI tools, apps, and fonts are declared in the `Brewfile` — it is the source of truth.

## Settings
- Git | `.gitconfig`
- Neovim | `.config/nvim/`
- Starship | `.config/starship.toml`
- tmux | `.tmux.conf`
- Ghostty | `.config/ghostty/`
- Zsh | `.zshrc` `.zshenv` `.zsh_plugins.txt` `.zprofile`

