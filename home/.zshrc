export PATH="$PATH:$HOME/bin/odin:$HOME/.cargo/bin:$HOME/.local/bin"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Aliases
alias at="tmux attach -t"
alias cat="bat --paging=never"
alias ls="eza --git --icons=auto"
alias ll="eza -l --git --icons=auto"
alias la="eza -la --git --icons=auto"

# Plugins via antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load
antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh
source ~/.zsh_plugins.zsh

# Completions
autoload -Uz compinit && compinit

# Google Cloud SDK
if [ -f '/Users/marktilton/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/marktilton/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/marktilton/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/marktilton/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Prompt and shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"
