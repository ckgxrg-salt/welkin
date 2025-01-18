{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Host
    '';
    "issue".text = ''
      Welkin is online
    '';
  };

  # Users & Groups
  users = {
    users = {
      # System administration & maintance
      "akacloud" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [
          "wheel"
          "libvirtd"
        ];
        description = "System administrator";
      };
      # The target colmena will ssh into
      "deployer" = {
        isNormalUser = true;
        group = "deployer";
        home = "/var/empty";
        createHome = false;
        extraGroups = [ "wheel" ];
        description = "Colmena deployer";
      };
    };
    groups = {
      "deployer" = { };
    };
  };
}
