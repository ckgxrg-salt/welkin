{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7105 ];

  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 7105;
    domain = "welkin.ckgxrg.io";
    database.createLocally = true;
    passwordFile = "/var/secrets/paperless/admin-pass";
    environmentFile = "/var/secrets/paperless/env";
    settings = {
      PAPERLESS_REDIS = "unix:///run/redis/redis.sock";
      PAPERLESS_FORCE_SCRIPT_NAME = "/docs";
      PAPERLESS_STATIC_URL = "/docs/static/";
      PAPERLESS_ADMIN_USER = "ckgxrg";
      PAPERLESS_APPS = "allauth.socialaccount.providers.openid_connect";

      PAPERLESS_APP_TITLE = "Welkin Documents";
    };
  };

  users.users."paperless".extraGroups = [
    "secrets"
    "redis"
  ];

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "paperless";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "paperless" ];
  };
}
