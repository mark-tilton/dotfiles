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
    fd
    fzf
    stow
    font-hack-nerd-font
    zsh
    antidote
    tmux
    git
    gh
    neovim
    lazygit
    rustup
    npm
    dotnet
    betterdisplay
    pipx
    htop
    raycast
    obsidian
    dropbox
    bruno
    firefox
    alacritty
    discord
    1password
    spotify
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
