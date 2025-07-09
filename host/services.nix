{ ... }:
# Redirect domains to services
let
  mkHost = cfg: {
    useACMEHost = "ckgxrg.io";
    listenAddresses = [
      "[::0]"
    ];
    extraConfig = "encode\n" + cfg;
  };
  mkWelkin = cfg: {
    useACMEHost = "welkin.ckgxrg.io";
    listenAddresses = [
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
      https_port 8443
    '';
    virtualHosts = {
      "ckgxrg.io" = mkHost ''
        header /.well-known/matrix/* Content-Type application/json
        header /.well-known/matrix/* Access-Control-Allow-Origin *
        respond /.well-known/matrix/server `{"m.server": "stargazer.ckgxrg.io:443"}`
        respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"https://stargazer.ckgxrg.io"}}`
      '';
      "auth.welkin.ckgxrg.io" = mkWelkin ''
        reverse_proxy 192.168.50.101:1976
      '';
      "welkin.ckgxrg.io" = mkWelkin ''
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
      "davis.welkin.ckgxrg.io" = mkWelkin ''
        forward_auth 192.168.50.101:1976 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy 192.168.50.105:8567
      '';
      "firefly.welkin.ckgxrg.io" = mkWelkin ''
        forward_auth 192.168.50.101:1976 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy 192.168.50.105:9182
      '';
      "mealie.welkin.ckgxrg.io" = mkWelkin ''
        reverse_proxy 192.168.50.105:9275
      '';
      "todo.welkin.ckgxrg.io" = mkWelkin ''
        reverse_proxy 192.168.50.105:4571
      '';
      "trips.welkin.ckgxrg.io" = mkWelkin ''
        @frontend {
          not path /media* /admin* /static* /accounts*
        }
        reverse_proxy @frontend 192.168.50.106:8015
        reverse_proxy 192.168.50.106:8016
      '';
    };
  };

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [
      8443
    ];
    allowedUDPPorts = [
      8443
    ];
  };
}
