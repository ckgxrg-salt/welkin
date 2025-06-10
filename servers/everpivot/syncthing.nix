{ ... }:
{
  services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8384";
    user = "storage";
    group = "storage";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      options = {
        urAccepted = -1;
        crashReportingEnabled = false;
      };
      gui = {
        # Since it has no native support for SSO...
        insecureAdminAccess = true;
        insecureSkipHostcheck = true;
      };
      folders = {
        "Books" = {
          path = "/data/Books";
        };
        "Music" = {
          path = "/data/Music";
        };
        "KeeShare" = {
          path = "/data/KeeShare";
        };
      };
    };
  };

  # Huh?
  users.users.syncthing = {
    enable = false;
    isSystemUser = true;
    group = "storage";
  };

  services.frp.settings.proxies = [
    {
      name = "syncthing";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8384;
      remotePort = 7105;
    }
  ];
}
