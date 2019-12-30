# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':user:*:*' color 'no'
  zstyle ':user:module:prompt' theme 'off'
fi

function usermodload {
  local -a pmodules
  local -a pmodule_dirs
  local -a locations
  local pmodule
  local pmodule_location
  local pfunction_glob='^([_.]*|prompt_*_setup|README*|*~)(-.N:t)'

  pmodule_dirs=("${ZDOTDIR:-$HOME}/.zsh/modules" "${ZDOTDIR:-$HOME}/.zsh/contrib")

  # $argv is overridden in the anonymous function.
  pmodules=("$argv[@]")

  # Load user modules.
  for pmodule in "$pmodules[@]"; do
    if zstyle -t ":user:module:$pmodule" loaded 'yes' 'no'; then
      continue
    else
      locations=(${pmodule_dirs:+${^pmodule_dirs}/$pmodule(-/FN)})
      if (( ${#locations} > 1 )); then
        print "$0: conflicting module locations: $locations"
        continue
      elif (( ${#locations} < 1 )); then
        print "$0: no such module: $pmodule"
        continue
      fi

      # Grab the full path to this module
      pmodule_location=${locations[1]}

      # Add functions to $fpath.
      fpath=(${pmodule_location}/functions(/FN) $fpath)

      function {
        local pfunction

        # Extended globbing is needed for listing autoloadable function directories.
        setopt LOCAL_OPTIONS EXTENDED_GLOB

        # Load user functions.
        for pfunction in ${pmodule_location}/functions/$~pfunction_glob; do
          autoload -Uz "$pfunction"
        done
      }

      if [[ -s "${pmodule_location}/init.zsh" ]]; then
        source "${pmodule_location}/init.zsh"
      elif [[ -s "${pmodule_location}/${pmodule}.plugin.zsh" ]]; then
        source "${pmodule_location}/${pmodule}.plugin.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":user:module:$pmodule" loaded 'yes'
      else
        # Remove the $fpath entry.
        fpath[(r)${pmodule_location}/functions]=()

        function {
          local pfunction

          # Extended globbing is needed for listing autoloadable function
          # directories.
          setopt LOCAL_OPTIONS EXTENDED_GLOB

          # Unload user functions.
          for pfunction in ${pmodule_location}/functions/$~pfunction_glob; do
            unfunction "$pfunction"
          done
        }

        zstyle ":user:module:$pmodule" loaded 'no'
      fi
    fi
  done
}

# Checks if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

# Load Zsh modules.
zstyle -a ':user:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':user:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Load modules.
zstyle -a ':user:load' usermodule 'pmodules'
usermodload "$pmodules[@]"
unset pmodules
