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
        description = "Salty Salt";
      };
      # The target colmena will ssh into
      "hyhy156" = {
        isNormalUser = true;
        group = "deployer";
        home = "/var/empty";
        createHome = false;
        extraGroups = [ "wheel" ];
        description = "Rainy Rain";
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
