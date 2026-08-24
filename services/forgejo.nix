{ helpers, ... }:
{
  imports = [
    (helpers.mkDB "forgejo")
  ];

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      DEFAULT = {
        APP_NAME = "The Rainforest";
      };
      server = {
        DOMAIN = "rainforest.ckgxrg.io";
        ROOT_URL = "https://rainforest.ckgxrg.io";
        HTTP_PORT = 7200;
        SSH_DOMAIN = "rf-ssh.ckgxrg.io";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      session = {
        COOKIE_SECURE = true;
      };
    };
  };

  users.users."forgejo".extraGroups = [ "secrets" ];
}
