{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Heart of the Internet of Fundamentals
    '';
    "issue".text = ''
      You are not welcomed generally.
    '';
  };

  # Users & Groups
  users = {
    users = {
      # System administration & maintance
      "elekiana" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
        description = "Mysterious technician";
      };
    };
  };
}
