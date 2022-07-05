cd ~/repos/dotfiles/

# Install xcode command line tools
echo "Setting up command line tools"
xcode-select --install

# Setup homebrew
echo "Setting up homebrew"
if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew update

# Install font
echo "Installing hack nerd font"
if ! brew list font-hack-nerd-font; then
    brew tap homebrew/cask-fonts 
    brew install --cask font-hack-nerd-font
fi

# Setup zsh and oh-my-zsh
echo "Setting up zsh"
if ! brew list zsh; then
    brew install zsh
fi

# Setup oh-my-zsh
echo "Setting up oh-my-zsh"
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Setup tmux
echo "Setting up tmux"
if ! brew list tmux; then
    brew install tmux
    ln -s .tmux.conf ~
fi

# Setup git
echo "Setting up git"
if ! brew list git; then
    brew install git
    git config --global user.name "Mark Tilton"
    git config --global user.email "mark.tilton.a@gmail.com"
fi

# Setup GitHub CLI
echo "Setting up GitHub CLI"
if ! brew list gh; then
    brew install gh
fi

# Setup node
echo "Setting up node"
if ! brew list node; then
    brew install node
fi

# Setup neovim
echo "Setting up neovim"
if ! brew list neovim; then
    brew install neovim
    mkdir -p ~/.config/nvim
    ln -s init.vim ~/.config/nvim/
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
nvim +'PlugInstall --sync' +qa

# Setup rust
echo "Setting up rust"
if test ! $(which rustup); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
rustup update

# Install apps
echo "Installing apps"
apps=(
    alfred
    alacritty
    discord
    1password
    google-chrome
    spotify
    setapp
)
brew install --cask ${apps[@]}

# Link alacritty settings
ln -s .alacritty.yml ~

# Upgrade all packages
brew upgrade

# Cleanup brew
brew cleanup
