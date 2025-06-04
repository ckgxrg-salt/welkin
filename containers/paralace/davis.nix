{ ... }:
{
  services.davis = {
    enable = true;
    hostname = "davis.welkin.ckgxrg.io";
    database.driver = "postgresql";
    adminLogin = "ckgxrg";
    adminPasswordFile = "/var/secrets/davis/admin-passwd";
    appSecretFile = "/var/secrets/davis/app-secret";
    nginx = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8567;
        }
      ];
    };
  };

  services.frp.settings.proxies = [
    {
      name = "davis";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8567;
      remotePort = 7500;
    }
  ];
}
