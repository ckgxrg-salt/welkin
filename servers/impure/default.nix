{ ... }:
# Impure services
{
  imports = [
    ./settings.nix

    ./adventurelog.nix
  ];

  networking = {
    hostName = "Impure";
    hostId = "6ccdc04d";
  };

  microvm = {
    balloon = true;
    hypervisor = "cloud-hypervisor";
    vcpu = 4;
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
      {
        source = "/var/lib/microvms/impure/ssh";
        mountPoint = "/run/ssh";
        tag = "ssh";
        proto = "virtiofs";
      }
      {
        source = "/var/lib/microvms/impure/oci";
        mountPoint = "/var/lib/containers";
        tag = "oci";
        proto = "virtiofs";
      }
    ];
  };

  services.openssh.hostKeys = [
    {
      bits = 4096;
      path = "/run/ssh/ssh_host_rsa_key";
      type = "rsa";
    }
    {
      path = "/run/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];

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
