{ ... }:
# Services and their ports
# ======= Backbone =======
# - Caddy
# - ACME
# - Keycloak 7000
# - OAuth2-Proxy 7001
# - PostgreSQL
# - Cloudflared
# - Netbird
# ======= Services =======
# - Glance 7102
# - Syncthing 7104
# - Forgejo 7200
# - AlumniMap 7201
# - Twunnel 7400
# - Actual 7501
# - Tandoor Recipes 7502
# - Miniflux 7503
# - Nextcloud 7504
# - Immich 7505
let
  mkHost = cert: cfg: {
    useACMEHost = builtins.toString cert;
    listenAddresses = [
      "0.0.0.0"
      "[::0]"
    ];
    extraConfig = "encode\n" + cfg;
  };
in
{
  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https disable_certs
    '';
    virtualHosts = {
      "http://ckgxrg.io".extraConfig = ''
        reverse_proxy /.well-known/matrix/* 127.0.0.1:7400 {
          header_up Host {upstream_hostport}
        }
      '';
      "welkin.ckgxrg.io" = mkHost 1 ''
        handle {
          forward_auth 127.0.0.1:7001 {
            uri /oauth2/auth
            header_up X-Real-IP {remote_host}
            @error status 401
            handle_response @error {
              redir * /oauth2/sign_in?rd={scheme}://{host}{uri}
            }
          }
          reverse_proxy 127.0.0.1:7102
        }

        @auth path /auth /auth/*
        handle @auth {
          reverse_proxy 127.0.0.1:7000
        }

        handle /oauth2/* {
          reverse_proxy 127.0.0.1:7001 {
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-Uri {uri}
          }
        }

        handle_path /sync/* {
          forward_auth 127.0.0.1:7001 {
            uri /oauth2/auth
            header_up X-Real-IP {remote_host}
            @error status 401
            handle_response @error {
              redir * /oauth2/sign_in?rd={scheme}://{host}/sync{uri}
            }
          }
          reverse_proxy 127.0.0.1:7104
        }

        @bookmarks path /bookmarks /bookmarks/*
        handle @bookmarks {
          respond "Under Construction" 501
        }

        @rss path /rss /rss/*
        handle @rss {
          reverse_proxy 127.0.0.1:7503
        }

        handle_path /cloud/* {
          reverse_proxy 127.0.0.1:7504
        }

        @recipes path /recipes /recipes/*
        handle @recipes {
          reverse_proxy 127.0.0.1:7502
        }
      '';

      "gallery.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 127.0.0.1:7505
      '';

      "finance.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 127.0.0.1:7501
      '';
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [ 443 ];
  };
}
