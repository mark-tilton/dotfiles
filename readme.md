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
- Karabiner | `.config/karabiner/karabiner.json`
- AeroSpace | `.config/aerospace/aerospace.toml`

## Keyboard (Karabiner-Elements)
Caps lock taps as escape and holds as `ctrl+opt+cmd` — the mod for every AeroSpace binding (chosen to mirror Hyprland's Super on Linux). Right-cmd holds a home-row symbol layer.

Both are **complex modifications**, which apply to every keyboard automatically — including ones connected later. Don't add bindings as per-device simple modifications; those are what require re-enabling for each new keyboard.

