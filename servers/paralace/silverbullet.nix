{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7504 ];

  services.silverbullet = {
    enable = true;
    listenAddress = "0.0.0.0";
    listenPort = 7504;
    spaceDir = "/data/Notes";
    envFile = "/var/secrets/silverbullet/env";
  };

  users.users."silverbullet".extraGroups = [ "storage" ];
}
