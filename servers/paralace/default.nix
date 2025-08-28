{ ... }:
{
  imports = [
    ../common.nix

    ./davis.nix
    ./firefly-iii.nix
    ./mealie.nix
    ./miniflux.nix
    ./vikunja.nix
  ];

  networking = {
    hostName = "Paralace";
    hostId = "9532988b";
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.105/24"
            "2408:8214:124:1750:e251:d8ff:23ae:ea23/64"
          ];
          Gateway = "192.168.50.1";
          DNS = [ "192.168.50.1" ];
          IPv6AcceptRA = true;
          DHCP = "no";
        };
      };
    };
  };

  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Paralace
    '';
    "issue".text = ''
      Paralace is online
    '';
  };

  users = {
    users = {
      "lurocia" = {
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
