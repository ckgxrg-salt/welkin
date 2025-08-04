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
          addr = "0.0.0.0";
          port = 8567;
        }
      ];
    };
  };

  users.users."davis".extraGroups = [ "secrets" ];
}
