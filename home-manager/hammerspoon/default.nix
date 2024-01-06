{ config, pkgs, ... }:

{
    # I only use home-manager to keep my hammerspoon config in this repo as it's easier to manage and because
    # Hammerspoon has no support for the .config directory.
    # Actual modifications to my hammerspoon configuration are done through the HS application.
    home.file.".hammerspoon/init.lua".source = config.lib.file.mkOutOfStoreSymlink ./init.lua;
    home.file.".hammerspoon/Spoons".source = config.lib.file.mkOutOfStoreSymlink ./Spoons;
}