{ lib, ... }:
{
  services.filebrowser = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 8124;
      root = "/data";
      baseurl = "/files";
      "auth.method" = "proxy";
      "auth.header" = "Remote-User";
    };
  };

  # Why use DynamicUser if it need to access files...?
  systemd.services.filebrowser = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "filebrowser";
      group = "filebrowser";
    };
  };

  # Dedicated user
  users = {
    users."filebrowser" = {
      description = "Filebrowser";
      isSystemUser = true;
      group = "filebrowser";
      extraGroups = [ "storage" ];
    };
    groups."filebrowser" = { };
  };

  services.frp.settings.proxies = [
    {
      name = "filebrowser";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8124;
      remotePort = 7101;
    }
  ];
}
