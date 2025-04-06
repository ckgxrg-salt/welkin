{ ... }:
# Redirect domains to services
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "welkin.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            return = "404";
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
