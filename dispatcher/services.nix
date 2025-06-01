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
            proxyPass = "http://localhost:7102";
          };
          "/files/" = {
            proxyPass = "http://localhost:7101";
          };
          "/jellyfin/" = {
            proxyPass = "http://localhost:7103";
          };
          "/jellyfin/socket/" = {
            proxyPass = "http://localhost:7103";
            proxyWebsockets = true;
          };
          "/shiori/" = {
            proxyPass = "http://localhost:7104/";
          };
          "/sync/" = {
            proxyPass = "http://localhost:7105/";
          };
        };
      };
      "alumnimap.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            proxyPass = "http://localhost:7100";
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
      "dav.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            proxyPass = "http://localhost:7500";
          };
        };
      };
    };

    # SSH
    streamConfig = ''
      upstream archiva-ssh {
        server localhost:8002;
      }
      upstream goatfold-ssh {
        server localhost:8003;
      }
      server {
        listen 0.0.0.0:2222;
        listen [::0]:2222;
        proxy_pass archiva-ssh;
      }
      server {
        listen 0.0.0.0:2223;
        listen [::0]:2223;
        proxy_pass goatfold-ssh;
      }
    '';
  };

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [
      80
      443
      2222
      2223
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "ckgxrg@ckgxrg.io";
    };
  };
}
