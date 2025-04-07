{ ... }:
# The Matrix homeserver
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "matrix-synapse" ];
    ensureUsers = [
      {
        name = "matrix-synapse";
        ensureDBOwnership = true;
      }
    ];
  };

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "ckgxrg.io";
      public_baseurl = "https://stargazer.ckgxrg.io";
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "0.0.0.0" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = true;
            }
          ];
        }
      ];
    };
    extraConfigFiles = [
      "/etc/synapse/registration_secret.conf"
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 8008 ];
  };
}
