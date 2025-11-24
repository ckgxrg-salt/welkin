{ ... }:
{
  imports = [
    ../common.nix

    ./alumnimap.nix
    ./forgejo.nix
  ];

  networking = {
    hostName = "Archiva";
    hostId = "18324a96";
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
