{ ... }:
# Services and their ports
# ========================
# Everpivot 71:
# - Authelia 7100
# - Filebrowser 7101
# - Glance 7102
# - Jellyfin 7103
# - Syncthing 7104
# ========================
# Archiva 72:
# - Forgejo 7200
# ========================
# Goatfold 73:
# - Minecraft 7300
# ========================
# Stargazer 74:
# - Conduit 7400
# ========================
# Paralace 75:
# - Davis 7500
# - Firefly III 7501
# - Mealie 7502
# - Miniflux 7503
# - Silverbullet 7504
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
        reverse_proxy 192.168.50.101:1976
      '';
      "welkin.ckgxrg.io" = mkHost 1 ''
        handle {
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

        @notes path /notes /notes/*
        handle @notes {
          reverse_proxy 192.168.50.105:4600
        }
      '';
      "davis.welkin.ckgxrg.io" = mkHost 2 ''
        forward_auth 192.168.50.101:1976 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy 192.168.50.105:8567
      '';
      "firefly.welkin.ckgxrg.io" = mkHost 2 ''
        forward_auth 192.168.50.101:1976 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
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
