{ config, pkgs, ... }:

let
  caddyErrorPages = pkgs.runCommand "caddy-error-pages" { } ''
        mkdir -p "$out"
        cat > "$out/502.html" <<'HTML'
    <!doctype html>
    <html>
      <head>
        <meta charset="utf-8" />
        <title>Service not running</title>
        <style>
          body { font-family: system-ui, -apple-system, sans-serif; margin: 3rem; }
          code { background: #f4f4f5; padding: .15rem .35rem; border-radius: .35rem; }
          pre { background: #f4f4f5; padding: 1rem; border-radius: .5rem; overflow: auto; }
        </style>
      </head>
      <body>
        <h1>Nothing is listening for <code>{{.Host}}</code></h1>
        <p>The upstream for this vhost appears to be down.</p>
        <p>Status: <code>{{placeholder "http.error.status_code"}}</code></p>
        <p>Expected unix socket:</p>
        <pre><code>/${config.localIngress.socketDir}/{{.Host}}.sock</code></pre>
      </body>
    </html>
    HTML
  '';

  caddyfile = pkgs.writeText "Caddyfile" ''
    #{
    #  auto_https disable_redirects
    #}

    :80 {
        redir https://{host}{uri} permanent
    }

    :443 {
      tls internal {
        on_demand
      }
      reverse_proxy unix//${config.localIngress.socketDir}/{host}.sock

      handle_errors {
      		@upstream_down expression {http.error.status_code} in [502, 503, 504]

      		handle @upstream_down {
                root * ${caddyErrorPages}
                templates
                try_files /502.html
                file_server
      		}
      	}
    }
  '';
in
{
  launchd.daemons.caddy = {
    command = "${pkgs.caddy}/bin/caddy run --config ${caddyfile} --adapter caddyfile";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/var/log/caddy.log";
      StandardErrorPath = "/var/log/caddy.log";
      EnvironmentVariables = {
        HOME = "/var/root";
        XDG_DATA_HOME = "/var/lib/caddy";
      };
    };
  };

  environment.systemPackages = [
    pkgs.caddy
  ];
}
