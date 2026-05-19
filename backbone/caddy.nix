{ ... }:
# Services and their ports
# ======= Backbone =======
# - Caddy
# - ACME
# - Keycloak 7000
# - PostgreSQL
# - Cloudflared
# - Netbird
# ======= Services =======
# - Filebrowser 7101
# - Glance 7102
# - Jellyfin 7103
# - Syncthing 7104
# - Paperless 7105
# - Forgejo 7200
# - AlumniMap 7201
# - Minecraft 7300
# - Twunnel 7400
# - Firefly III 7501
# - Mealie 7502
# - Miniflux 7503
# - Nextcloud 7504
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
          reverse_proxy 127.0.0.1:7000
        }

        @auth path /auth /auth/*
        handle @auth {
          reverse_proxy 127.0.0.1:7000
        }

        @files path /files /files/*
        handle @files {
          forward_auth 10.7.0.1:7000 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          }
          reverse_proxy 10.7.0.1:7101
        }

        handle_path /sync/* {
          reverse_proxy 10.7.0.1:7104
        }

        @jellyfin path /jellyfin /jellyfin/*
        handle @jellyfin {
          reverse_proxy 10.7.0.1:7103
        }

        @bookmarks path /bookmarks /bookmarks/*
        handle @bookmarks {
          respond "Under Construction" 501
        }

        @rss path /rss /rss/*
        handle @rss {
          reverse_proxy 10.7.0.5:7503
        }

        @docs path /docs /docs/*
        handle @docs {
          reverse_proxy 10.7.0.1:7105
        }

        handle_path /cloud/* {
          reverse_proxy 127.0.0.1:7504
        }
      '';
      "firefly.welkin.ckgxrg.io" = mkHost 2 ''
        forward_auth 10.7.0.1:7100 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy 10.7.0.5:7501
      '';
      "mealie.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 10.7.0.5:7502
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
