{ ... }:
# Minecraft servers
{
  imports = [
    ./nextcloud.nix
    ./frp.nix
    ./login.nix
    ./security.nix
    ./settings.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Paralace";
    hostId = "9532988b";
  };

  system.stateVersion = "24.11";
}
