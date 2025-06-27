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
      passwordFile = "/var/secrets/gitea/dbpasswd";
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
        extraGroups = [ "secrets" ];
      };
    };
    groups = {
      "gitea" = {
        gid = 995;
      };
    };
  };

  services.frp.settings.proxies = [
    {
      name = "gitea-ssh";
      type = "tcp";
      localip = "127.0.0.1";
      localport = 22;
      remoteport = 7222;
    }
    {
      name = "gitea";
      type = "tcp";
      localip = "127.0.0.1";
      localport = 8999;
      remoteport = 7200;
    }
  ];
}
