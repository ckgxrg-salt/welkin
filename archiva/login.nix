{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Archiva
    '';
    "issue".text = ''
      Archiva is online
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
  };
}
