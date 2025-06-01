{ ... }:
{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    group = "storage";
    settings = {
      options = {
        urAccepted = -1;
        crashReportingEnabled = false;
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
