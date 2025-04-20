{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Paralace
    '';
    "issue".text = ''
      Paralace is online
    '';
  };

  # Users
  users = {
    users = {
      # System administration & maintance
      "lurocia" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
        description = "Mysterious";
      };
    };
  };
}
