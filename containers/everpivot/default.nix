{ ... }:
# Miscellaneous services
{
  imports = [
    ../common.nix

    ./services/adguard.nix
    ./services/alumnimap.nix
    ./services/glance.nix
    ./services/jellyfin.nix
    ./services/shiori.nix
  ];

  networking = {
    hostName = "Everpivot";
    hostId = "f058329f";
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.101/24"
            "2408:8215:123:16d0:e251:d8ff:95ca:72a1/64"
          ];
          Gateway = "192.168.50.1";
          DNS = [ "192.168.50.1" ];
          IPv6AcceptRA = true;
          DHCP = "no";
        };
      };
    };
  };

  services.frp = {
    enable = true;
    role = "client";
    settings = {
      serverAddr = "welkin.ckgxrg.io";
      serverPort = 7000;
    };
  };

  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Everlight Pivot
    '';
    "issue".text = ''
      Everlight Pivot is online
    '';
  };

  users.users = {
    # System administration & maintance
    "bse" = {
      isNormalUser = true;
      uid = 1001;
      extraGroups = [
        "wheel"
        "storage"
      ];
      description = "System administrator";
      openssh.authorizedKeys.keyFiles = [
        ../../misc/daywatch-ssh.pub
        ../../misc/rhyslow-ssh.pub
      ];
    };
  };

  system.stateVersion = "24.11";
}
