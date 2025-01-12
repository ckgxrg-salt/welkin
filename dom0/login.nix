{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Domain 0
    '';
    "issue".text = ''
      Dunno what to say yet...
    '';
  };

  # Users & Groups
  users = {
    users = {
      # System administration & maintance
      "akacloud" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
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
