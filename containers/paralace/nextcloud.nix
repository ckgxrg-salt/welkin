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
      breezedark = pkgs.fetchNextcloudApp {
        url = "https://github.com/mwalbeck/nextcloud-breeze-dark/releases/download/v29.0.0/breezedark.tar.gz";
        license = "agpl3Only";
        hash = "sha256-9xMH9IcQrzzMJ5bL6RP/3CS1QGuByriCjGkJQJxQ4CU=";
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
