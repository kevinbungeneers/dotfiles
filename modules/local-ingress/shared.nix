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
      default = "/var/run/local-ingress";
      description = "Root directory for keeping local sockets.";

      # Ensure callers don't set a relative path by mistake.
      apply =
        dir:
        if lib.hasPrefix "/" dir then
          dir
        else
          throw "localIngress.socketDir must be an absolute path (got: ${dir})";
    };

    groupId = mkOption {
      type = types.int;
      default = 2000;
      description = "The group ID to use for the local-ingress group.";
    };
  };
}
