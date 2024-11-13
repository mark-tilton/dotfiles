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
    stow
    zsh
    font-hack-nerd-font
    tmux
    git
    gh
    neovim
    rustup
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
    echo "Installing $app"
    if ! brew list "$app"; then
        brew install "$app"
    fi
done

# Install docker through cask
if ! brew list docker; then
    brew install --cask docker
fi

# Upgrade all packages
brew upgrade

# Cleanup brew
brew cleanup

# Set git config
git config --global user.name "Mark Tilton"
git config --global user.email "mark.tilton.a@gmail.com"

# Setup oh-my-zsh
echo "Setting up oh-my-zsh"
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install rust via rustup
rustup update
