{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Everlight Pivot
    '';
    "issue".text = ''
      Everlight Pivot is online
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
