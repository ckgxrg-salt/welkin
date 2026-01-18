{ ... }:
{
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Host
    '';
    "issue".text = ''
      Welkin is online
    '';
  };

  users = {
    users = {
      "akacloud" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [
          "wheel"
          "storage"
        ];
        description = "System Administrator";
        openssh.authorizedKeys.keyFiles = [
          ../keys/daywatch-ssh.pub
          ../keys/rhyslow-ssh.pub
        ];
      };
      "deployer" = {
        isNormalUser = true;
        uid = 1002;
        group = "deployer";
        home = "/var/empty";
        createHome = false;
        extraGroups = [ "wheel" ];
        description = "Colmena deployer";
        openssh.authorizedKeys.keyFiles = [
          ../keys/daywatch-ssh.pub
          ../keys/rhyslow-ssh.pub
        ];
      };
      "storage" = {
        description = "Storage user";
        isSystemUser = true;
        uid = 1024;
        group = "storage";
      };
    };
    groups = {
      "deployer" = { };
      "storage".gid = 1024;
      "secrets".gid = 1437;
    };
  };
}
