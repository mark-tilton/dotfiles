cd ~/repos/dotfiles/ || exit

# Install xcode command line tools
echo "Setting up command line tools"
xcode-select --install

# Install homebrew
echo "Installing homebrew"
if test ! "$(which brew)"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew update

# Install apps
echo "Installing homebrew packages"
apps=(
    # Symlinks
    stow

    # Fuzzy finder
    fd
    fzf
    rg

    # Terminal
    zsh
    antidote
    tmux
    neovim

    # Git and Github
    git
    gh
    lazygit

    # Languages / Package Managers
    cmake
    dotnet
    htop
    luarocks
    npm
    pipx
    rustup

    # Fonts
    font-hack-nerd-font
    font-fira-code
    sf-symbols
    font-sketchybar-app-font

    # Apps
    1password
    alacritty
    betterdisplay
    bruno
    discord
    docker
    dropbox
    firefox
    karabiner-elements
    obsidian
    raycast
    rectangle
    sketchybar
    spotify
    wezterm
)

brew tap FelixKratz/formulae
for app in "${apps[@]}"; do
    if ! brew list "$app"; then
        echo "Installing $app"
        brew install "$app"
    fi
done

# Upgrade all packages
brew upgrade

# Cleanup brew
brew cleanup

# Set git config
git config --global user.name "Mark Tilton"
git config --global user.email "mark.tilton.a@gmail.com"
git config --global core.excludesfile ~/.gitignore_global

# Stow dotfiles
./stow_dotfiles.sh

# Install alacritty gruvbox theme
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# Install lua configuration support for sketchybar
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
# Start sketchybar at startup
brew services start sketchybar

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install rust via rustup
rustup update
