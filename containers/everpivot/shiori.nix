{ ... }:
# Shiori the bookmark manager
{
  services.shiori = {
    enable = true;
    webRoot = "shiori";
    address = "127.0.0.1";
    port = 8089;
    databaseUrl = "postgres:///shiori?host=/run/postgresql";
    environmentFile = "/var/secrets/shiori/env";
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "shiori" ];
    ensureUsers = [
      {
        name = "shiori";
        ensureDBOwnership = true;
      }
    ];
  };

  services.frp.settings.proxies = [
    {
      name = "shiori";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8089;
      remotePort = 7104;
    }
  ];
}
