{ ... }:
# Redirect domains to services
let
  mkHost = cfg: {
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
      http_port 8080
      https_port 8443
      auto_https off
    '';
    virtualHosts = {
      "http://ckgxrg.io" = mkHost ''
        header /.well-known/matrix/* Content-Type application/json
        header /.well-known/matrix/* Access-Control-Allow-Origin *
        respond /.well-known/matrix/server `{"m.server": "stargazer.ckgxrg.io:443"}`
        respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"https://stargazer.ckgxrg.io"}}`
      '';
      "auth.welkin.ckgxrg.io" = mkHost ''
        reverse_proxy 192.168.50.101:1976
      '';
      "welkin.ckgxrg.io" = mkHost ''
        handle {
          forward_auth 192.168.50.101:1976 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          }
          reverse_proxy 192.168.50.101:5678
        }

        @files path /files /files/*
        handle @files {
          forward_auth 192.168.50.101:1976 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          }
          reverse_proxy 192.168.50.101:8124
        }

        handle_path /sync/* {
          forward_auth 192.168.50.101:1976 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          }
          reverse_proxy 192.168.50.101:8384
        }

        @jellyfin path /jellyfin /jellyfin/*
        handle @jellyfin {
          reverse_proxy 192.168.50.101:8096
        }

        @bookmarks path /bookmarks /bookmarks/*
        handle @bookmarks {
          respond "Under Construction" 501
        }

        @miniflux path /miniflux /miniflux/*
        handle @miniflux {
          reverse_proxy 192.168.50.105:9124
        }
      '';
      "http://davis.welkin.ckgxrg.io" = mkHost ''
        forward_auth 192.168.50.101:1976 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy 192.168.50.105:8567
      '';
      "http://firefly.welkin.ckgxrg.io" = mkHost ''
        forward_auth 192.168.50.101:1976 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy 192.168.50.105:9182
      '';
      "http://mealie.welkin.ckgxrg.io" = mkHost ''
        reverse_proxy 192.168.50.105:9275
      '';
      "http://todo.welkin.ckgxrg.io" = mkHost ''
        reverse_proxy 192.168.50.105:4571
      '';
    };
  };
}
