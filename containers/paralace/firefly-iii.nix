{ ... }:
{
  services.firefly-iii = {
    enable = true;
    enableNginx = true;
    virtualHost = "localhost";
    settings = {
      APP_URL = "https://firefly.paralace.ckgxrg.io";
      TRUSTED_PROXIES = "**";
      DB_CONNECTION = "pgsql";
      APP_KEY_FILE = "/etc/firefly-iii/app-key";
    };
  };

  services.nginx.virtualHosts."localhost".listen = [
    {
      addr = "127.0.0.1";
      port = 9182;
    }
  ];

  services.postgresql = {
    ensureUsers = [
      {
        name = "firefly-iii";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "firefly-iii" ];
  };

  services.frp.settings.proxies = [
    {
      name = "firefly-iii";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 9182;
      remotePort = 7501;
    }
  ];
}
