{ ... }:
{
  imports = [
    ../common.nix

    ./minecraft.nix
  ];

  networking = {
    hostName = "Goatfold";
    hostId = "951c4139";
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.103/24"
            "2408:8215:123:16d0:e251:d8ff:81bc:1da2/64"
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
      Welcome from the Welkin - Goatfold
    '';
    "issue".text = ''
      Goatfold is online
    '';
  };

  users = {
    users = {
      "slat" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
        description = "Salty Salt";
        openssh.authorizedKeys.keyFiles = [
          ../../keys/daywatch-ssh.pub
          ../../keys/rhyslow-ssh.pub
          ../../keys/asedia-ssh.pub
        ];
      };
      "goat" = {
        isNormalUser = true;
        uid = 1002;
        group = "minecraft";
        home = "/srv/minecraft";
        description = "Goaty Goat";
        openssh.authorizedKeys.keyFiles = [
          ../../keys/daywatch-ssh.pub
          ../../keys/rhyslow-ssh.pub
          ../../keys/asedia-ssh.pub
        ];
      };
    };
    groups."minecraft" = { };
  };

  system.stateVersion = "24.11";
}
