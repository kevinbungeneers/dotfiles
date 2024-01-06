{
  description = "My commandline life";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    devenv.url = "github:cachix/devenv/latest";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, nixpkgs, devenv, ... }:
    let
      system = "aarch64-darwin";
      overlay = final: prev: {
        inherit nixpkgs;
        devenv = devenv.packages.${system}.devenv;
      };
      pkgs = (nixpkgs.legacyPackages.${system}.extend overlay);
    in {
      homeConfigurations = {
        "kevin@Kevins-MacBook-Pro" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager
          ];
        };
      };
    };
}