{ helpers, pkgs, ... }:
{
  imports = [
    (helpers.mkDB "keycloak")
  ];

  services.keycloak = {
    enable = true;
    database = {
      createLocally = false;
      host = "/run/postgresql";
    };
    plugins = with pkgs.keycloak.plugins; [
      junixsocket-common
      junixsocket-native-common
    ];
    settings = {
      hostname = "welkin.ckgxrg.io";
      http-relative-path = "/auth";
      http-enabled = true;
      http-port = 7000;
      proxy-headers = "xforwarded";
      hostname-strict-https = false;
    };
  };
}
