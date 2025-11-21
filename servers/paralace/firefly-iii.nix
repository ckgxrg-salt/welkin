{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7501 ];

  services.firefly-iii = {
    enable = true;
    enableNginx = true;
    virtualHost = "firefly";
    settings = {
      APP_URL = "https://firefly.welkin.ckgxrg.io";
      TRUSTED_PROXIES = "**";
      DB_CONNECTION = "pgsql";
      APP_KEY_FILE = "/var/secrets/firefly-iii/app-key";

      AUTHENTICATION_GUARD = "remote_user_guard";
      AUTHENTICATION_GUARD_HEADER = "Remote-Email";
    };
  };

  users.users."firefly-iii".extraGroups = [ "secrets" ];

  services.nginx.virtualHosts."firefly".listen = [
    {
      addr = "0.0.0.0";
      port = 7501;
    }
  ];

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "firefly-iii";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "firefly-iii" ];
  };
}
