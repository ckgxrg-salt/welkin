{ config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 7504 ];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "localhost";
    database.createLocally = true;
    settings = {
      trusted_domains = [ "welkin.ckgxrg.io" ];
      overwriteprotocol = "https";
      overwritewebroot = "/cloud";
      overwritehost = "welkin.ckgxrg.io";
    };
    config = {
      dbtype = "pgsql";
      adminuser = "ckgxrg";
      adminpassFile = "/var/secrets/nextcloud/admin-pass";
    };

    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        calendar
        contacts
        deck
        tasks
        mail
        ;
      sociallogin = pkgs.fetchNextcloudApp {
        sha256 = "sha256-1wyQlxuyYFbAB9KLq2VSWZ/8zbdGmzq7UlkAYuZUgJc=";
        url = "https://github.com/zorn-v/nextcloud-social-login/releases/download/v6.3.0/release.tar.gz";
        license = "agpl3Only";
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "nextcloud" ];
  };

  services.nginx.virtualHosts."localhost".listen = [
    {
      addr = "0.0.0.0";
      port = 7504;
    }
  ];

  users.users."nextcloud".extraGroups = [ "secrets" ];
}
