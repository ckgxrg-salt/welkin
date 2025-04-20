{ config, pkgs, ... }:
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
        cookbook
        deck
        memories
        music
        tasks
        ;
      passman = pkgs.fetchNextcloudApp {
        url = "https://releases.passman.cc/passman_2.4.12.tar.gz";
        license = "agpl3Only";
        hash = "sha256-nLwd67w/8drY/V/aPWZj2bVTuYmJpNNX0h6qnG+UQm4=";
      };
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

  # Dedicated user
  users = {
    users."nextcloud" = {
      description = "Nextcloud user";
      isSystemUser = true;
      uid = 1024;
      group = "nextcloud";
      extraGroups = [ "storage" ];
    };
    groups."nextcloud" = {
      gid = 1024;
    };
  };
}
