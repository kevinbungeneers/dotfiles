{
  programs.zsh = {
    enable = true;

    initContent = ''
      if test -x $HOME/.local/bin/mise; then
          eval "$($HOME/.local/bin/mise activate zsh)"
      fi

      export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin:$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

      # Check if Go is installed and add $GOPATH/bin to the PATH
      if type go >/dev/null 2>&1; then
          GOPATH=$(go env GOPATH)
          export PATH="$GOPATH/bin:$PATH"
      fi
    '';
  };
}
