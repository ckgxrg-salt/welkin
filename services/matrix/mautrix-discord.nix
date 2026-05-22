{ helpers, ... }:
{
  imports = [
    (helpers.mkDB "mautrix-discord")
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  services.mautrix-discord = {
    enable = true;
    environmentFile = "/run/secrets/matrix-discord/env";
    settings = {
      bridge = {
        mute_only_on_create = false;
        permissions = {
          "ckgxrg.io" = "user";
          "@ckgxrg:ckgxrg.io" = "admin";
        };
        backfill.enabled = true;
        encryption = {
          allow = true;
          default = true;
        };
        login_shared_secret_map = {
          "ckgxrg.io" = "as_token:$DOUBLE_PUPPET_KEY";
        };
      };
      appservice = {
        database = {
          type = "postgres";
          uri = "postgresql:///mautrix-discord?host=/run/postgresql";
        };
      };
      homeserver = {
        address = "http://127.0.0.1:7400";
        domain = "ckgxrg.io";
      };
    };
  };
}
