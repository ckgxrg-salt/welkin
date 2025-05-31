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

  services.frp.settings.proxies = [
    {
      name = "jellyfin";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8096;
      remotePort = 7004;
    }
  ];
}
