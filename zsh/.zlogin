# Execute code that does not affect the current session in the background.
(
  local dir file
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  autoload -U zrecompile

  # zcompile the completion cache; siginificant speedup
  zrecompile -pq ${ZDOTDIR:-${HOME}}/${zcompdump_file:-.zcompdump}

  # zcompile .zshrc
  zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshrc

  # zcompile enabled module autoloaded functions
  for dir in ${ZDOTDIR:-${HOME}}/.zsh/modules/${^zmodules}/functions(/FN); do
    zrecompile -pq ${dir}.zwc ${dir}/^(_*|prompt_*_setup|*.*)(-.N)
  done

  # zcompile enabled module scripts
  for file in ${ZDOTDIR:-${HOME}}/.zsh/modules/${^zmodules}/(^*test*/)#*.zsh{,-theme}(.NLk+1); do
    zrecompile -pq ${file}
  done

  # zcompile all prompt setup scripts
  for file in ${ZDOTDIR:-${HOME}}/.zsh/modules/prompt/functions/prompt_*_setup; do
    zrecompile -pq ${file}
  done
) &!