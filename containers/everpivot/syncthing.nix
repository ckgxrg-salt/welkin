{ ... }:
{
  services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8384";
    group = "storage";
    overrideDevices = false;
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

  users.users."syncthing" = {
    extraGroups = [ "storage" ];
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
