{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  services.mautrix-whatsapp = {
    enable = true;
    environmentFile = "/var/secrets/matrix-whatsapp/env";
    settings = {
      network.os_name = "Matrix-WhatsApp";
      appservice.ephemeral_events = false;
      backfill.enabled = true;
      bridge = {
        mute_only_on_create = false;
        permissions = {
          "ckgxrg.io" = "user";
          "@ckgxrg:ckgxrg.io" = "admin";
        };
      };
      database = {
        type = "postgres";
        uri = "postgresql:///mautrix-whatsapp?host=/run/postgresql";
      };
      encryption = {
        allow = true;
        default = true;
        pickle_key = "$PICKLE_KEY";
      };
      homeserver = {
        address = "http://127.0.0.1:7400";
        domain = "ckgxrg.io";
      };
    };
  };

  systemd.services.mautrix-telegram.path = [ pkgs.ffmpeg ];

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "mautrix-whatsapp";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "mautrix-whatsapp" ];
  };
}
