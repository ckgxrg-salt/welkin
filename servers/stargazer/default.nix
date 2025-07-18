{ ... }:
# Communication related
{
  imports = [
    ../common.nix

    ./conduit.nix
    ./matrix-qq.nix
    ./v2raya.nix
  ];

  networking = {
    hostName = "Stargazer";
    hostId = "f5bd64b0";
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.104/24"
            "2408:8214:124:1750:e251:d8ff:214e:8251/64"
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
          name = "stargazer-ssh";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 22;
          remotePort = 7422;
        }
      ];
    };
  };

  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Stargazer
    '';
    "issue".text = ''
      Stargazer is online
    '';
  };

  # Users
  users = {
    users = {
      # System administration & maintance
      "psichilus" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
        description = "Mysterious";
        openssh.authorizedKeys.keyFiles = [
          ../../keys/daywatch-ssh.pub
          ../../keys/rhyslow-ssh.pub
          ../../keys/asedia-ssh.pub
        ];
      };
    };
  };

  system.stateVersion = "24.11";
}
