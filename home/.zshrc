export PATH="$PATH:$HOME/bin/odin:$HOME/.cargo/bin:$HOME/.local/bin"

# Aliases
alias at="tmux attach -t"
alias cat="bat --paging=never"
alias ls="eza --git --icons=auto"
alias ll="eza -l --git --icons=auto"
alias la="eza -la --git --icons=auto"

# Git
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gp="git push"
alias gl="git pull"
alias gf="git fetch"
alias glog="git log --oneline --graph --decorate"

# Plugins via antidote (ez-compinit in the plugin list handles compinit)
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

# Prompt and shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"
