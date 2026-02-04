{ config, pkgs, ... }:

{
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Nix installation/daemon is managed externally (e.g. Determinate or upstream installer),
  # not by nix-darwin.
  nix.enable = false;

  programs.fish.enable = true;
  programs.zsh.enable = false;

  users.users.kevin = {
    name = "kevin";
    home = "/Users/kevin";
    shell = pkgs.fish;
  };

  localIngress = {
    tlds = [ "test" ];
    socketDir = "${config.users.users.kevin.home}/Developer/.local-ingress";
  };

  imports = [
    ../../modules/local-ingress/darwin.nix
  ];
}
