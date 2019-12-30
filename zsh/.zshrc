# Define the modules to be loaded
zstyle ':user:load' usermodule \
    'history' \
    'directory' \
    'utility' \
    'completion' \
    'syntax-highlighting' \
    'history-substring-search' \
    'autosuggestions' \
    'prompt'

zstyle ':user:module:syntax-highlighting' highlighters \
  'main' \
  'brackets' \
  'pattern' \
  'line' \
  'cursor' \
  'root'

# Colorize all the things
zstyle ':user:*:*' color 'yes'

# Set 'pure' as the prompt
zstyle ':user:module:prompt' theme 'pure'

# Initialize ZSH modules and configuration
if [[ -s "${ZDOTDIR:-$HOME}/.zsh/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/init.zsh"
fi