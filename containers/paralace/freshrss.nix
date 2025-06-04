{ ... }:
{
  services.freshrss = {
    enable = true;
    defaultUser = "ckgxrg";
    passwordFile = "/var/secrets/freshrss/passwd";
    baseUrl = "https://freshrss.welkin.ckgxrg.io";
    database = {
      type = "pgsql";
      port = 5432;
    };
  };

  services.nginx.virtualHosts."freshrss".listen = [
    {
      addr = "127.0.0.1";
      port = 9124;
    }
  ];

  services.postgresql = {
    ensureUsers = [
      {
        name = "freshrss";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "freshrss" ];
  };

  services.frp.settings.proxies = [
    {
      name = "freshrss";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 9124;
      remotePort = 7503;
    }
  ];
}
