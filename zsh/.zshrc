# Define the modules to be loaded
zstyle ':user:load' usermodule \
    'history' \
    'completion' \
    'syntax-highlighting' \
    'history-substring-search' \
    'autosuggestions' \
    'prompt'

# Set 'pure' as the prompt
zstyle ':user:module:prompt' theme 'pure'

# Initialize ZSH modules and configuration
if [[ -s "${ZDOTDIR:-$HOME}/.zsh/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/init.zsh"
fi