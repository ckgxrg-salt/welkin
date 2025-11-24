{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7400 ];

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
        allow_registration = false;
      };
    };
  };

  systemd.services.conduit.serviceConfig.EnvironmentFile =
    "/var/secrets/conduit/registration-token.env";
}
