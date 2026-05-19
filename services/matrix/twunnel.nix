{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7400 ];

  services.matrix-tuwunel = {
    enable = true;
    settings = {
      global = {
        server_name = "ckgxrg.io";
        address = [ "0.0.0.0" ];
        port = [ 7400 ];
        new_user_displayname_suffix = "";
        allow_registration = false;
        appservice_dir = "/var/lib/tuwunel-appservices";
        well_known = {
          client = "https://stargazer.ckgxrg.io";
          server = "stargazer.ckgxrg.io:443";
        };
      };
    };
  };

  systemd.services.tuwunel.serviceConfig.EnvironmentFile = "/run/secrets/tuwunel/env";
}
