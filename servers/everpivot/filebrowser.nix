{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 8124 ];

  services.filebrowser = {
    enable = true;
    settings = {
      address = "0.0.0.0";
      port = 8124;
      root = "/data";
      baseurl = "/files";
      "auth.method" = "proxy";
      "auth.header" = "Remote-User";
    };
  };

  systemd.services.filebrowser.serviceConfig.SupplementaryGroups = [ "storage" ];
}
