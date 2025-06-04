{ ... }:
{
  services.mealie = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 9275;
    settings = {
      BASE_URL = "https://mealie.welkin.ckgxrg.io";
      DB_ENGINE = "postgres";
      POSTGRES_SERVER = "localhost";
    };
  };

  services.postgresql = {
    ensureUsers = [
      {
        name = "mealie";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "mealie" ];
  };

  services.frp.settings.proxies = [
    {
      name = "mealie";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 9275;
      remotePort = 7502;
    }
  ];
}
