{ ... }:
{
  services.matrix-conduit = {
    enable = true;
    settings = {
      global = {
        server_name = "ckgxrg.io";
        address = "127.0.0.1";
        port = 8008;
        database_backend = "rocksdb";
        allow_check_for_updates = false;
        enable_lightning_bolt = false;
        allow_registration = true;
      };
    };
  };

  systemd.services.conduit.serviceConfig.EnvironmentFile =
    "/var/secrets/conduit/registration-token.env";

  services.frp.settings.proxies = [
    {
      name = "conduit";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8008;
      remotePort = 7400;
    }
  ];
}
