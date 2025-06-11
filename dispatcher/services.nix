{ ... }:
# Redirect domains to services
let
  mkHost = cfg: {
    useACMEHost = "ckgxrg.io";
    listenAddresses = [
      "0.0.0.0"
      "[::0]"
    ];
    extraConfig = "encode\n" + cfg;
  };
  mkWelkin = cfg: {
    useACMEHost = "welkin.ckgxrg.io";
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
      "ckgxrg.io" = mkHost ''
        header /.well-known/matrix/* Content-Type application/json
        header /.well-known/matrix/* Access-Control-Allow-Origin *
        respond /.well-known/matrix/server `{"m.server": "stargazer.ckgxrg.io:443"}`
        respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"https://stargazer.ckgxrg.io"}}`
      '';
      "auth.welkin.ckgxrg.io" = mkWelkin ''
        reverse_proxy localhost:7106
      '';
      "welkin.ckgxrg.io" = mkWelkin ''
        handle {
          forward_auth localhost:7106 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
            header_up Proxy-Authorization {header.authorization}
          }
          reverse_proxy localhost:7102
        }

        @files path /files /files/*
        handle @files {
          forward_auth localhost:7106 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
            header_up Proxy-Authorization {header.authorization}
          }
          reverse_proxy localhost:7101
        }

        handle_path /sync/* {
          forward_auth localhost:7106 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
            header_up Proxy-Authorization {header.authorization}
          }
          reverse_proxy localhost:7105
        }

        @jellyfin path /jellyfin /jellyfin/*
        handle @jellyfin {
          reverse_proxy localhost:7103
        }

        @bookmarks path /bookmarks /bookmarks/*
        handle @bookmarks {
          respond "Under Construction" 501
        }

        @miniflux path /miniflux /miniflux/*
        handle @miniflux {
          reverse_proxy localhost:7503
        }
      '';
      "stargazer.ckgxrg.io" = mkHost ''
        reverse_proxy /_matrix/* localhost:7400
        reverse_proxy /_synapse/client/* localhost:7400
      '';
      "alumnimap.ckgxrg.io" = mkHost ''
        reverse_proxy localhost:7100
      '';
      "archiva.ckgxrg.io" = mkHost ''
        reverse_proxy localhost:7200
      '';
      "davis.welkin.ckgxrg.io" = mkWelkin ''
        forward_auth localhost:7106 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          header_up Proxy-Authorization {header.authorization}
        }
        reverse_proxy localhost:7500
      '';
      "firefly.welkin.ckgxrg.io" = mkWelkin ''
        forward_auth localhost:7106 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
          header_up Proxy-Authorization {header.authorization}
        }
        reverse_proxy localhost:7501 {
          header_up Proxy-Authorization {header.authorization}
        }
      '';
      "mealie.welkin.ckgxrg.io" = mkWelkin ''
        reverse_proxy localhost:7502
      '';
      "todo.welkin.ckgxrg.io" = mkWelkin ''
        reverse_proxy localhost:7504
      '';
      "trips.welkin.ckgxrg.io" = mkWelkin ''
        @frontend {
          not path /media* /admin* /static* /accounts*
        }
        reverse_proxy @frontend localhost:7600
        reverse_proxy localhost:7601
      '';
    };
  };

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [
      80
      443
      7222
    ];
    allowedUDPPorts = [
      443
    ];
  };

  sops.secrets."cloudflare" = {
    sopsFile = ../secrets/dispatcher/default.yaml;
  };
  users.users."caddy".extraGroups = [ "acme" ];
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "ckgxrg@ckgxrg.io";
    };
    certs = {
      "ckgxrg.io" = {
        domain = "*.ckgxrg.io";
        dnsProvider = "cloudflare";
        environmentFile = "/run/secrets/cloudflare";
      };
      "welkin.ckgxrg.io" = {
        domain = "*.welkin.ckgxrg.io";
        dnsProvider = "cloudflare";
        environmentFile = "/run/secrets/cloudflare";
      };
    };
  };
}
