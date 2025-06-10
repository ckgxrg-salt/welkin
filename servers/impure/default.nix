{ pkgs, ... }:
# Impure services
{
  imports = [
    ./settings.nix
  ];

  networking = {
    hostName = "Impure";
    hostId = "6ccdc04d";
  };

  microvm = {
    balloon = true;
    hypervisor = "cloud-hypervisor";
    hotplugMem = 6 * 1024;
    hotpluggedMem = 512;
    interfaces = [
      {
        type = "tap";
        id = "vm-impure";
        mac = "32:da:01:52:be:21";
      }
    ];
    shares = [
      {
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        tag = "ro-store";
        proto = "virtiofs";
      }
      {
        source = "/run/secrets/impure";
        mountPoint = "/var/secrets";
        tag = "secrets";
        proto = "virtiofs";
      }
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_lqx;

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.106/24"
            "2408:8215:123:16d0:e251:d8ff:91ba:e891/64"
          ];
          Gateway = "192.168.50.1";
          DNS = [ "192.168.50.1" ];
          IPv6AcceptRA = true;
          DHCP = "no";
        };
      };
      "19-docker" = {
        matchConfig.Name = "veth*";
        linkConfig = {
          Unmanaged = true;
        };
      };
    };
  };

  system.stateVersion = "24.11";
}
