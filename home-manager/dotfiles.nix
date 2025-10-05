{ lib, config, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.dotfiles.path = mkOption {
    type = types.str;
    default = "${config.home.homeDirectory}/.dotfiles";
    description = "Anchor path to your dotfiles checkout (directory or symlink).";
  };
}
