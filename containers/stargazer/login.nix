{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Welcome from the Welkin - Stargazer
    '';
    "issue".text = ''
      Stargazer is online
    '';
  };

  # Users
  users = {
    users = {
      # System administration & maintance
      "psichilus" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
        description = "Mysterious";
      };
    };
  };
}
