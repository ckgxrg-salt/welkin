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
        ENABLE_NOTIFY_MAIL = true;
      };
      session = {
        COOKIE_SECURE = true;
      };
      mailer = {
        ENABLED = true;
        PROTOCOL = "smtps";
        FROM = "Irida <irida@ckgxrg.io>";
        SMTP_PORT = 465;
      };
    };
    secrets = {
      mailer = {
        SMTP_ADDR = "/run/secrets/forgejo/smtp-addr";
        USER = "/run/secrets/forgejo/smtp-user";
        PASSWD = "/run/secrets/forgejo/smtp-passwd";
      };
    };
  };
}
