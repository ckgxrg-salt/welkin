{ ... }:
{
  services.davis = {
    enable = true;
    hostname = "davis.welkin.ckgxrg.io";
    database.driver = "postgresql";
    adminLogin = "ckgxrg";
    adminPasswordFile = "/dev/null";
    appSecretFile = "/var/secrets/davis/app-secret";
    config = {
      # Use Authelia
      ADMIN_AUTH_BYPASS = true;
    };
    nginx = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8567;
        }
      ];
    };
  };

  users.users."davis".extraGroups = [ "secrets" ];

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
