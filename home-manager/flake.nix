{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      mkHome = { system, user, home, extraModules ? [ ], extraSpecialArgs ? { } }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./dotfiles.nix
            ./home.nix
            { home.username = user; home.homeDirectory = home; }
          ] ++ extraModules;
          extraSpecialArgs = extraSpecialArgs;
        };
    in {
      homeConfigurations = {
        "kevin" = mkHome {
          system = "aarch64-darwin";
          user = "kevin";
          home = "/Users/kevin";
        };
      };
    };
}
