{ ckgs, ... }:
{
  # Dedicated user
  users = {
    users."alumnimap" = {
      description = "AlumniMap Staging";
      isSystemUser = true;
      group = "alumnimap";
    };
    groups."alumnimap" = { };
  };

  services.postgresql.enable = true;

  environment.systemPackages = [
    ckgs.alumnimap
  ];

  systemd.services.alumnimap = {
    description = "AlumniMap";
    serviceConfig = {
      ExecStart = "${ckgs.alumnimap}/bin/alumnimap server";
    };
  };

  services.frp.settings.proxies = [
    {
      name = "alumnimap";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8080;
      remotePort = 7078;
    }
  ];
}
