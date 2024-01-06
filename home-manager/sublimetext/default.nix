{ config, pkgs, ... }:

{
  # I've opted to move the ST settings that are common across my machines to /home-manager/Preferences.sublime-settings
  # so that I still have the ability to configure each ST installation individually as I see fit
  # without having issues with the preferences file managed by ST.
  home.file."Library/Application Support/Sublime Text/Packages/home-manager/Preferences.sublime-settings".source = ./Preferences.sublime-settings;
}