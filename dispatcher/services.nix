{ ... }:
# Redirect domains to services
let
  mkHost = locations: {
    forceSSL = true;
    useACMEHost = "ckgxrg.io";
    listenAddresses = [
      "0.0.0.0"
      "[::0]"
    ];
    inherit locations;
  };
in
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedZstdSettings = true;
    virtualHosts = {
      "ckgxrg.io" =
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
        mkHost {
          "/".return = "403";
          "/.well-known/matrix/server".extraConfig = mkWellKnown serverCfg;
          "/.well-known/matrix/client".extraConfig = mkWellKnown clientCfg;
        };
      "welkin.ckgxrg.io" = mkHost {
        "/".proxyPass = "http://localhost:7102";
        "/files/".proxyPass = "http://localhost:7101";
        "/jellyfin/".proxyPass = "http://localhost:7103";
        "/jellyfin/socket/" = {
          proxyPass = "http://localhost:7103";
          proxyWebsockets = true;
        };
        "/shiori/".proxyPass = "http://localhost:7104/";
        "/sync/".proxyPass = "http://localhost:7105/";
      };
      "stargazer.ckgxrg.io" = mkHost {
        "/".return = "403";
        "/_matrix".proxyPass = "http://localhost:7400";
        "/_synapse/client".proxyPass = "http://localhost:7400";
      };
      "alumnimap.ckgxrg.io" = mkHost {
        "/".proxyPass = "http://localhost:7100/";
      };
      "archiva.ckgxrg.io" = mkHost {
        "/".proxyPass = "http://localhost:7300/";
      };
      "davis.welkin.ckgxrg.io" = mkHost {
        "/".proxyPass = "http://localhost:7500/";
      };
      "firefly.welkin.ckgxrg.io" = mkHost {
        "/".proxyPass = "http://localhost:7501/";
      };
      "mealie.welkin.ckgxrg.io" = mkHost {
        "/".proxyPass = "http://localhost:7502/";
      };
      "freshrss.welkin.ckgxrg.io" = mkHost {
        "/".proxyPass = "http://localhost:7503/";
      };
    };
  };

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [
      80
      443
      7322
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };

  sops.secrets."cloudflare" = {
    sopsFile = ../secrets/dispatcher.yaml;
  };
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "ckgxrg@ckgxrg.io";
    };
    certs."ckgxrg.io" = {
      domain = "*.ckgxrg.io";
      dnsProvider = "cloudflare";
      environmentFile = "/run/secrets/cloudflare";
    };
  };
}
