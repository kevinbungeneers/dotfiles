{ config, pkgs, ... }:

{
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Nix install is currently being managed by the Determinate distribution.
  # Will switch to the vanilla upstream Nix distribution later.
  nix.enable = false;

  programs.fish.enable = true;

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