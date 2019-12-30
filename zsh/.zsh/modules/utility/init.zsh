if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first'

  if zstyle -t ':user:module:utility:ls' color; then
    # Call dircolors to define colors if they're missing
    if [[ -z "$LS_COLORS" ]]; then
      if [[ -s "$HOME/.dir_colors" ]]; then
        eval "$(dircolors --sh "$HOME/.dir_colors")"
      else
        eval "$(dircolors --sh)"
      fi
    fi

    alias ls="${aliases[ls]:-ls} --color=auto"
  else
    alias ls="${aliases[ls]:-ls} -F"
  fi
else
  # BSD Core Utilities
  if zstyle -t ':user:module:utility:ls' color; then
    # Define colors for BSD ls if they're not already defined
    if [[ -z "$LSCOLORS" ]]; then
      export LSCOLORS='exfxcxdxbxGxDxabagacad'
    fi

    # Define colors for the completion system if they're not already defined
    if [[ -z "$LS_COLORS" ]]; then
      export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
    fi

    alias ls="${aliases[ls]:-ls} -G"
  else
    alias ls="${aliases[ls]:-ls} -F"
  fi
fi

alias ll='ls -lh' # Lists human readable sizes.
alias la='ll -A'  # Lists human readable sizes, hidden files.