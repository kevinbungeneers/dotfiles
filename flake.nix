{
  description = "macOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
        url = "github:nix-darwin/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-pkgs, home-manager, darwin, ... }:
    {
      darwinConfigurations = {
        "Kevins-MacBook-Pro" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix-darwin/default.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kevin = {
                imports = [
                 ./home-manager/dotfiles.nix
                 ./home-manager/home.nix
                ];
              };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    };
}
