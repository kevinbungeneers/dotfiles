{
  config,
  pkgs,
  user,
  ...
}:

{
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Nix installation/daemon is managed externally (e.g. Determinate or upstream installer),
  # not by nix-darwin.
  nix.enable = false;

  programs.fish.enable = true;
  programs.zsh.enable = false;

  users.users.${user.name} = {
    name = user.name;
    home = user.homeDir;
  };

  localIngress = {
    tlds = [ "test" ];
  };

  imports = [
    ../../modules/local-ingress/darwin.nix
  ];
}
