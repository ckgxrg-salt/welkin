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
      "stargazer.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          return = "403";
        };
        locations."/_matrix".proxyPass = "http://10.1.10.104:8008";
        locations."/_synapse/client".proxyPass = "http://10.1.10.104:8008";
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
      "jellyfin.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            proxyPass = "http://10.1.10.101:8096";
          };
          "/socket" = {
            proxyPass = "http://10.1.10.101:8096";
            proxyWebsockets = true;
          };
        };
      };
      "radicale.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            proxyPass = "http://10.1.10.101:5232";
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
            proxyPass = "http://10.1.10.102:8999";
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
