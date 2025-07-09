{ ... }:
# Study & Project management
{
  imports = [
    ../common.nix

    ./gitea.nix
  ];

  networking = {
    hostName = "Archiva";
    hostId = "18324a96";
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.102/24"
            "2408:8215:123:16d0:e251:d8ff:5bd9:8a1c/64"
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
      proxies = [
        {
          name = "archiva-ssh";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 22;
          remotePort = 7222;
        }
      ];
    };
  };

  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Archiva
    '';
    "issue".text = ''
      Archiva is online
    '';
  };

  users.users = {
    # System administration & maintance
    "cresilexica" = {
      isNormalUser = true;
      uid = 1001;
      extraGroups = [ "wheel" ];
      description = "System administrator";
      openssh.authorizedKeys.keyFiles = [
        ../../keys/daywatch-ssh.pub
        ../../keys/rhyslow-ssh.pub
        ../../keys/asedia-ssh.pub
      ];
    };
  };

  system.stateVersion = "24.11";
}
