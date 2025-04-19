{ ... }:
# Shiori the bookmark manager
{
  services.shiori = {
    enable = true;
    webRoot = "shiori";
    address = "127.0.0.1";
    port = 8089;
    databaseUrl = "postgres:///shiori?host=/run/postgresql";
    environmentFile = "/etc/shiori/env";
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
}
