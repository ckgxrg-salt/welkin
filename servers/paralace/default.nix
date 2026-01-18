{ ... }:
{
  imports = [
    ../common.nix

    ./firefly-iii.nix
    ./mealie.nix
    ./miniflux.nix
    ./nextcloud.nix
  ];

  networking = {
    hostName = "Paralace";
    hostId = "9532988b";
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
        ];
      };
      "storage" = {
        isSystemUser = true;
        uid = 1024;
        group = "storage";
      };
    };
    groups."storage" = { };
  };

  system.stateVersion = "24.11";
}
