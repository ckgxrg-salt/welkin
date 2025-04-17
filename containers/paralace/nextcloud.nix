{ config, ... }:
# Nextcloud configuration
{
  services.nextcloud = {
    enable = true;
    hostName = "localhost";
    database.createLocally = true;
    settings = {
      trusted_proxies = [ "209.38.172.211" ];
      trusted_domains = [ "paralace.ckgxrg.io" ];
      overwriteprotocol = "https";
    };
    config = {
      dbtype = "pgsql";
      adminpassFile = "/etc/nextcloud/admin-pass";
    };

    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        calendar
        contacts
        memories
        tasks
        ;
    };
  };

  services.postgresql = {
    enable = true;
  };
  services.nginx.virtualHosts."localhost".listen = [
    {
      addr = "0.0.0.0";
      port = 8079;
    }
  ];
  networking.firewall = {
    allowedTCPPorts = [
      8079
    ];
  };

  # Dedicated user
  users = {
    users."nextcloud" = {
      description = "Nextcloud user";
      isSystemUser = true;
      group = "nextcloud";
    };
    groups."nextcloud" = { };
  };
}
