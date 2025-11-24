{ ... }:
{
  imports = [
    ../common.nix

    ./conduit.nix
    ./matrix-qq.nix
    ./matrix-whatsapp.nix
  ];

  networking = {
    hostName = "Stargazer";
    hostId = "f5bd64b0";
  };

  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Stargazer
    '';
    "issue".text = ''
      Stargazer is online
    '';
  };

  users = {
    users = {
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
