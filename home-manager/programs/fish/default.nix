{
  enable = true;
  shellInit = ''
    # Source the nix daemon
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end

    # Activate mise for this session
    if type -q $HOME/.local/bin/mise
      eval "$($HOME/.local/bin/mise activate fish)"
    end

    # Disable the fish greeting
    set -g fish_greeting
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
    fish_prompt = {
      body = ''
        echo -ne '\n❱ '
      '';
    };
  };

#  plugins = with pkgs.fishPlugins; [
#    { name = "fzf-fish"; src = fzf-fish.src; }
#  ];
}