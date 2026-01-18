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
        ];
      };
    };
    groups."minecraft" = { };
  };

  system.stateVersion = "24.11";
}
