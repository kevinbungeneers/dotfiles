{ config, pkgs, ... }:

{
  # Symlink the ~/.config/zed/settings.json file directly to the settings.josn file in this directory.
  # Might become obsolete once https://github.com/zed-industries/zed/issues/20038 has been resolved.
  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.path}/modules/editor/zed/settings.json";
}
