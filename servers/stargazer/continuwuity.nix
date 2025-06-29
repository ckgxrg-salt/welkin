{ ... }:
{
  services.matrix-continuwuity = {
    enable = true;
    settings = {
      global = {
        server_name = "ckgxrg.io";
        address = [
          "127.0.0.1"
          "::1"
        ];
        port = [ 8008 ];
        allow_announcements_check = false;
        new_user_displayname_suffix = "";
      };
    };
  };

  systemd.services.continuwuity.serviceConfig.EnvironmentFile =
    "/var/secrets/continuwuity/registration-token.env";

  services.frp.settings.proxies = [
    {
      name = "continuwuity";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8008;
      remotePort = 7400;
    }
  ];
}
