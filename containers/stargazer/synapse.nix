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
      "/var/secrets/synapse/registration_secret.conf"
    ];
  };

  services.frp.settings.proxies = [
    {
      name = "stargazer";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8008;
      remotePort = 7400;
    }
  ];
}
