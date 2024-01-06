{ config, pkgs, ... }:

{
    programs.go = {
        enable = true;
        goPath = "Projects/go";
    };
}