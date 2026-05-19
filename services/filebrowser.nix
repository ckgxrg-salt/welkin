{ ... }:
{
  services.filebrowser = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 7101;
      root = "/data";
      baseurl = "/files";
      "auth.method" = "noauth";
      # "auth.method" = "proxy";
      # "auth.header" = "Remote-User";
    };
  };

  systemd.services.filebrowser.serviceConfig.SupplementaryGroups = [ "storage" ];
}
