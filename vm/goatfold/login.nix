{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Goatfold
    '';
    "issue".text = ''
      Goatfold is online
    '';
  };

  # Users
  users = {
    users = {
      # System administration & maintance
      "slat" = {
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
      # This user actually runs Minecraft servers
      "goat" = {
        isNormalUser = true;
        uid = 1002;
        home = "/srv/minecraft";
        description = "Goaty Goat";
      };
    };
    groups = {
      "deployer" = { };
    };
  };
}
