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
    package = pkgs.nextcloud34;
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
        sociallogin
        ;
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
