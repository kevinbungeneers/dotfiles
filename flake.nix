{
  description = "Kevin's Dotfiles";

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

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      ...
    }:
    let
      hosts = {
        Kevins-MacBook-Pro = {
          system = "aarch64-darwin";
          user = {
            name = "kevin";
            homeDir = "/Users/kevin";
            dotfilesDir = "/Users/kevin/.dotfiles";
          };
          hmModule = ./users/kevin/default.nix;
          hostModule = ./hosts/Kevins-MacBook-Pro/default.nix;
        };
      };

      mkDarwinHost =
        host:
        darwin.lib.darwinSystem {
          system = host.system;

          # available in all darwin modules as `host` and `user`
          specialArgs = {
            inherit host;
            user = host.user;
          };

          modules = [
            host.hostModule
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # available in HM modules as `host` and `user`
              home-manager.extraSpecialArgs = {
                inherit host;
                user = host.user;
              };

              home-manager.users.${host.user.name} = import host.hmModule;
            }
          ];
        };
    in
    {
      darwinConfigurations = {
        "Kevins-MacBook-Pro" = mkDarwinHost hosts.Kevins-MacBook-Pro;
      };

      formatter.aarch64-darwin =
        let
          pkgs = import nixpkgs { system = "aarch64-darwin"; };
        in
        pkgs.nixfmt-tree;
    };
}
