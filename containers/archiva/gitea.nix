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
        DOMAIN = "archiva.ckgxrg.io";
        ROOT_URL = "https://archiva.ckgxrg.io";
        HTTP_PORT = 8999;
        DISABLE_REGISTRATION = true;
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
        ensureDBOwnership = true;
      }
    ];
  };

  # Gitea related users
  users = {
    users = {
      "gitea" = {
        description = "Gitea Service";
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

  networking.firewall = {
    allowedTCPPorts = [
      22
      8999
    ];
  };
}
