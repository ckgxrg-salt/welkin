{ ... }:
# Redirect domains to services
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
        reverse_proxy 192.168.50.101:1976
      '';
      "welkin.ckgxrg.io" = mkHost 1 ''
        handle {
          reverse_proxy 192.168.50.101:5678
        }

        @files path /files /files/*
        handle @files {
          reverse_proxy 192.168.50.101:8124
        }

        handle_path /sync/* {
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
      "davis.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 192.168.50.105:8567
      '';
      "firefly.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 192.168.50.105:9182
      '';
      "mealie.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 192.168.50.105:9275
      '';
      "todo.welkin.ckgxrg.io" = mkHost 2 ''
        reverse_proxy 192.168.50.105:4571
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
