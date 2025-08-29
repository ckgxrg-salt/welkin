{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 4600 ];

  services.silverbullet = {
    enable = true;
    listenAddress = "0.0.0.0";
    listenPort = 4600;
    spaceDir = "/data/Notes";
    envFile = "/var/secrets/silverbullet/env";
  };

  users.users."silverbullet".extraGroups = [ "storage" ];
}
