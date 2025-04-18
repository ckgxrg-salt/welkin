{ ... }:
# Redirect domains to services
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedZstdSettings = true;
    virtualHosts = {
      "ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations =
          let
            clientCfg = {
              "m.homeserver".base_url = "https://stargazer.ckgxrg.io";
            };
            serverCfg = {
              "m.server" = "stargazer.ckgxrg.io:443";
            };
            mkWellKnown = data: ''
              default_type application/json;
              add_header Access-Control-Allow-Origin *;
              return 200 '${builtins.toJSON data}';
            '';
          in
          {
            "/" = {
              return = "403";
            };
            "/.well-known/matrix/server" = {
              extraConfig = mkWellKnown serverCfg;
            };
            "/.well-known/matrix/client" = {
              extraConfig = mkWellKnown clientCfg;
            };
          };
      };
      "welkin.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            return = "403";
          };
        };
      };
      "stargazer.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          return = "403";
        };
        locations."/_matrix".proxyPass = "http://localhost:7002";
        locations."/_synapse/client".proxyPass = "http://localhost:7002";
      };
      "everpivot.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            return = "403";
          };
          "/obsidian" = {
            extraConfig = ''
              rewrite /obsidian/(.*) /$1 break;
            '';
            proxyPass = "http://localhost:7006";
          };
          "/jellyfin" = {
            proxyPass = "http://localhost:7004";
          };
          "/jellyfin/socket" = {
            proxyPass = "http://localhost:7004";
            proxyWebsockets = true;
          };
        };
      };
      "archiva.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            proxyPass = "http://localhost:7003";
          };
        };
      };
      "paralace.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            proxyPass = "http://localhost:7001";
          };
        };
      };
    };
  };

  # Open firewall
  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [
      80
      443
      51820
    ];
    allowedUDPPorts = [
      80
      443
      51820
    ];
  };
}
