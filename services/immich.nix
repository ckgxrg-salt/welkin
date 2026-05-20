{ helpers, ... }:
{
  imports = [
    (helpers.mkDB "immich")
  ];

  services.immich = {
    enable = true;
    database = {
      enable = true;
      createDB = false;
    };
    redis = {
      enable = true;
    };
    mediaLocation = "/data/Pictures";
    host = "127.0.0.1";
    port = 7505;
  };

  users.users.immich.extraGroups = [ "storage" ];
}
