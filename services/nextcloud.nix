{
  helpers,
  config,
  pkgs,
  ...
}:
{
  imports = [
    (helpers.mkDB "nextcloud")
  ];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
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
      adminpassFile = "/run/secrets/nextcloud/admin-pass";
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
        sha256 = "sha256-DUX3nBABqKklkCHaYL3/L5ge+F43Mu9kY9jlzxGwecE=";
        url = "https://github.com/zorn-v/nextcloud-social-login/releases/download/v6.5.2/release.tar.gz";
        license = "agpl3Only";
      };
    };
  };

  services.nginx.virtualHosts."localhost".listen = [
    {
      addr = "0.0.0.0";
      port = 7504;
    }
  ];

  users.users."nextcloud".extraGroups = [ "secrets" ];
}
