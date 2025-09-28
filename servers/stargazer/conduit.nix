{ ... }:
{
  services.matrix-conduit = {
    enable = true;
    settings = {
      global = {
        server_name = "ckgxrg.io";
        address = "0.0.0.0";
        port = 7400;
        database_backend = "rocksdb";
        allow_check_for_updates = false;
        enable_lightning_bolt = false;
        allow_registration = true;
        #proxy.by_domain = [
        #  {
        #    url = "socks5h://127.0.0.1:20170";
        #    include = [
        #      "matrix.org"
        #      "*.matrix.org"
        #    ];
        #  }
        #];
      };
    };
  };

  systemd.services.conduit.serviceConfig.EnvironmentFile =
    "/var/secrets/conduit/registration-token.env";
}
