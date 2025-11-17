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
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${ckgs.alumnimap}/bin/alumnimap server";
    };
  };
}
