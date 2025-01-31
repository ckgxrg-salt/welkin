{ ... }:
# Gitlab
{
  services.gitlab = {
    enable = true;
    https = true;
    host = "git.ckgxrg.io";
    port = 9000;
    statePath = "/var/lib/gitlab";
    databaseName = "archiva";
    databaseUsername = "gitlab";
    databasePasswordFile = "/etc/gitlab/secrets/dbpasswd";
    initialRootPasswordFile = "/var/empty";
    user = "gitlab";
    group = "gitlab";
    secrets = {
      secretFile = "/etc/gitlab/secrets/secret";
      otpFile = "/etc/gitlab/secrets/otp";
      jwsFile = "/etc/gitlab/secrets/jws";
      dbFile = "/etc/gitlab/secrets/db";
    };
  };

  # Gitlab related users
  users = {
    users = {
      "gitlab" = {
        description = "Gitlab";
        isSystemUser = true;
        group = "gitlab";
      };
    };
    groups = {
      "gitlab" = { };
    };
  };
}
