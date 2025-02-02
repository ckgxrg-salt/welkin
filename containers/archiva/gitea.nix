{ ... }:
# Gitea
{
  services.gitea = {
    enable = true;
    appName = "Archiva Gitea";
    database = {
      type = "postgres";
      name = "gitea";
      user = "gitea";
      passwordFile = "/etc/gitea/secrets/dbpasswd";
    };
    settings = {
      server = {
        DOMAIN = "git.ckgxrg.io";
        ROOT_URL = "https://git.ckgxrg.io:9000";
        HTTP_PORT = 9000;
      };
      session = {
        COOKIE_SECURE = true;
      };
    };
  };

  # Gitea database
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "gitea" ];
    ensureUsers = [
      {
        name = "gitea";
        ensurePermissions = {
          "DATABASE gitea" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  # Gitea related users
  users = {
    users = {
      "gitea" = {
        description = "Gitea";
        isSystemUser = true;
        uid = 996;
        group = "gitea";
      };
    };
    groups = {
      "gitea" = {
        gid = 995;
      };
    };
  };
}
