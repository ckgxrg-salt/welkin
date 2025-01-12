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
  users.users = {
    # System administration & maintance
    "akacloud" = {
      isNormalUser = true;
      uid = 1001;
      extraGroups = [ "wheel" ];
      description = "System administrator";
    };
    # This user actually runs Minecraft servers
    "goat" = {
      isNormalUser = true;
      uid = 1002;
      home = "/srv/minecraft";
      description = "Goaty Goat";
    };
  };
}
