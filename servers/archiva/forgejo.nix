{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7200 ];

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    settings = {
      DEFAULT = {
        APP_NAME = "Archiva";
      };
      server = {
        DOMAIN = "archiva.ckgxrg.io";
        ROOT_URL = "https://archiva.ckgxrg.io";
        HTTP_PORT = 7200;
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      session = {
        COOKIE_SECURE = true;
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "forgejo" ];
    ensureUsers = [
      {
        name = "forgejo";
        ensureDBOwnership = true;
      }
    ];
  };

  users = {
    users = {
      "forgejo" = {
        description = "Forgejo Service";
        isSystemUser = true;
        group = "forgejo";
        extraGroups = [ "secrets" ];
      };
    };
    groups = {
      "forgejo" = { };
    };
  };
}
