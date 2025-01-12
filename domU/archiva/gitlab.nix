{ ... }:
# Gitlab
{
  services.gitlab = {
    enable = true;
    https = true;
    statePath = "/var/lib/gitlab";
    databaseName = "archiva";
    databaseUsername = "gitlab-db";
    databasePasswordFile = "/run/gitlab/secrets/dbpasswd";
    user = "gitlab";
    group = "gitlab";
    secrets = {
      secretFile = "/run/gitlab/secrets/db";
      otpFile = "/run/gitlab/secrets/otp";
      jwsFile = "/run/gitlab/secrets/jws";
      dbFile = "/run/gitlab/secrets/db";
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
      "gitlab-db" = {
        description = "Gitlab Database";
        isSystemUser = true;
        group = "gitlab";
      };
    };
    groups = {
      "gitlab" = { };
    };
  };
}
