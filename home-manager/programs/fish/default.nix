{
  enable = true;
  shellInit = ''
    # Nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
    # End Nix

    if type -q $HOME/.local/bin/mise
      eval "$($HOME/.local/bin/mise activate fish)"
    end
  '';

  shellAliases = {
    cat = "bat --paging=never";
    doco = "docker compose";
  };

  functions = {
    fish_title = {
      body = ''
        printf '\a\e]7;file://''${hostname}/%s' (echo -n $PWD | sed 's/ /%20/g')
      '';
    };
  };

#  plugins = with pkgs.fishPlugins; [
#    { name = "fzf-fish"; src = fzf-fish.src; }
#  ];
}