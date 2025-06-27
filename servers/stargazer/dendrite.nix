{ ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "dendrite" ];
    ensureUsers = [
      {
        name = "dendrite";
        ensureDBOwnership = true;
      }
    ];
  };

  services.dendrite = {
    enable = true;
    httpPort = 8008;
    settings = {
      global = {
        private_key = "/var/secrets/dendrite/matrix-key";
        server_name = "ckgxrg.io";
        database = {
          connection_string = "postgres://dendrite@localhost/dendrite?sslmode=disable";
        };
      };
    };
  };

  systemd.services.dendrite.serviceConfig.SupplementaryGroups = [ "secrets" ];

  services.frp.settings.proxies = [
    {
      name = "dendrite";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8008;
      remotePort = 7400;
    }
  ];
}
