{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7101 ];

  services.filebrowser = {
    enable = true;
    settings = {
      address = "0.0.0.0";
      port = 7101;
      root = "/data";
      baseurl = "/files";
      "auth.method" = "proxy";
      "auth.header" = "Remote-User";
    };
  };

  systemd.services.filebrowser.serviceConfig.SupplementaryGroups = [ "storage" ];
}
