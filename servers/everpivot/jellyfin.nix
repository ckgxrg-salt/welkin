{ ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "jellyfin";
    group = "jellyfin";
  };

  users = {
    users."jellyfin" = {
      description = "Jellyfin Media Server";
      isSystemUser = true;
      group = "jellyfin";
      extraGroups = [
        "storage"
      ];
    };
    groups."jellyfin" = { };
  };
}
