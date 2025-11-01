{ ... }:
{
  imports = [
    ../common.nix

    ./adguard.nix
    ./authelia.nix
    ./alumnimap.nix
    ./filebrowser.nix
    ./glance.nix
    ./jellyfin.nix
    ./syncthing.nix
  ];

  networking = {
    hostName = "Everpivot";
    hostId = "f058329f";
  };

  systemd.tmpfiles.rules = [
    "d /data 770 storage storage - -"
  ];

  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Everlight Pivot
    '';
    "issue".text = ''
      Everlight Pivot is online
    '';
  };

  users = {
    users = {
      "bse" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [
          "wheel"
          "storage"
        ];
        description = "System administrator";
        openssh.authorizedKeys.keyFiles = [
          ../../keys/daywatch-ssh.pub
          ../../keys/rhyslow-ssh.pub
          ../../keys/asedia-ssh.pub
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
