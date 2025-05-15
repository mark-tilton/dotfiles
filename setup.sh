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

    # Apps
    1password
    alacritty
    betterdisplay
    bruno
    discord
    dropbox
    firefox
    karabiner-elements
    obsidian
    raycast
    rectangle
    spotify
    wezterm
)
for app in "${apps[@]}"; do
    if ! brew list "$app"; then
        echo "Installing $app"
        brew install "$app"
    fi
done

# Install docker through cask
if ! brew list docker; then
    echo "Installing docker"
    brew install --cask docker
fi

# Install alacritty gruvbox theme
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# Upgrade all packages
brew upgrade

# Cleanup brew
brew cleanup

# Set git config
git config --global user.name "Mark Tilton"
git config --global user.email "mark.tilton.a@gmail.com"

# Install rust via rustup
rustup update
