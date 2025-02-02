{ ... }:
# Jellyfin Media Server
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "jellyfin";
    group = "jellyfin";
  };

  # Dedicated user
  users = {
    users."jellyfin" = {
      description = "Jellyfin Media Server";
      isSystemUser = true;
      group = "jellyfin";
      extraGroups = [
        "samba"
      ];
    };
    groups."jellyfin" = { };
  };
}
