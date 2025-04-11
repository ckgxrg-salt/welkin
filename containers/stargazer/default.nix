{ ... }:
# Minecraft servers
{
  imports = [
    ./frp.nix
    ./login.nix
    ./security.nix
    ./settings.nix

    ./synapse.nix
    ./bridge-qq.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Stargazer";
    hostId = "f5bd64b0";
  };

  system.stateVersion = "24.11";
}
