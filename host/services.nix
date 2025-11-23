{ ... }:
# Services and their ports
# ========================
# Everpivot 10.7.0.1:
# - Authelia 7100
# - Filebrowser 7101
# - Glance 7102
# - Jellyfin 7103
# - Syncthing 7104
# - Paperless 7105
# ========================
# Archiva 10.7.0.2:
# - Forgejo 7200
# - AlumniMap 7201
# ========================
# Goatfold 10.7.0.3:
# - Minecraft 7300
# ========================
# Stargazer 10.7.0.4:
# - Conduit 7400
# ========================
# Paralace 10.7.0.5:
# - Davis 7500
# - Firefly III 7501
# - Mealie 7502
# - Miniflux 7503
# - Vikunja 7505
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
        header /.well-known/matrix/* Content-Type application/json
        header /.well-known/matrix/* Access-Control-Allow-Origin *
        respond /.well-known/matrix/server `{"m.server": "stargazer.ckgxrg.io:443"}`
        respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"https://stargazer.ckgxrg.io"}}`
      '';
      "auth.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 10.7.0.1:7100
      '';
      "welkin.ckgxrg.io" = mkHost 1 ''
        handle {
          reverse_proxy 10.7.0.1:7102
        }

        @files path /files /files/*
        handle @files {
          forward_auth 10.7.0.1:7100 {
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
      '';
      "dav.welkin.ckgxrg.io" = mkHost 2 ''
        forward_auth 10.7.0.1:7100 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy 10.7.0.5:7500
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
      "todo.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 10.7.0.5:7505
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
