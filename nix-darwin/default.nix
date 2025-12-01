{ pkgs, ...}:

let
  devTld = "test";
  vhostsRoot = "/Users/kevin/Developer/.vhosts";

  caddyfile = pkgs.writeText "Caddyfile" ''
    {
      acme_ca internal
      admin on
      auto_https disable_redirects
    }

    *.${devTld} {
      reverse_proxy unix//${vhostsRoot}/{http.request.host}.sock
    }
  '';
in
{
    users.users.kevin = {
     name = "kevin";
     home = "/Users/kevin";
     shell = pkgs.fish; # or whatever shell you want
   };

   programs.fish.enable = true;

    nixpkgs.hostPlatform = "aarch64-darwin";

    # Nix install is currently being managed by the Determinate distribution.
    # Will switch to the vanilla upstream Nix distribution later.
    nix.enable = false;

    #system.configurationRevision = self.rev or self.dirtyRev or null;
    system.stateVersion = 6;

    services.dnsmasq = {
      enable = true;
      addresses = {
        ${devTld} = "127.0.0.1";
      };
    };

    launchd.daemons.caddy = {
      command = "${pkgs.caddy}/bin/caddy run --config ${caddyfile} --adapter caddyfile";
      serviceConfig = {
        RunAtLoad = true;
        KeepAlive = true;
        StandardOutPath = "/var/log/caddy.log";
        StandardErrorPath = "/var/log/caddy.log";
        EnvironmentVariables = {
          HOME = "/Users/kevin";
          XDG_DATA_HOME = "/Users/kevin/Library/Application Support";
        };
      };
    };

    environment.systemPackages = [
      pkgs.caddy
    ];
}
