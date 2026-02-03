{ lib, ... }:

let
    inherit (lib) mkOption types;
in
{
    options.localIngress = {
        tlds = mkOption {
            type = types.listOf types.str;
            default = [ "test" ];
            description = "TLDs that should resolve to localhost for local development.";
        };

        socketDir = mkOption {
            type = types.str;
            default = "";
            description = "Root directory for keeping local sockets.";
        };
    };
}