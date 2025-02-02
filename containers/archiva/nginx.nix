{ ... }:
# Make Gitea accessible
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "git.ckgxrg.io" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/" = {
          proxyPass = "http://localhost:8999";
        };
        listen = [
          {
            addr = "0.0.0.0";
            port = 9000;
            ssl = true;
          }
          {
            addr = "[::0]";
            port = 9000;
            ssl = true;
          }
        ];
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      9000
    ];
  };
}
