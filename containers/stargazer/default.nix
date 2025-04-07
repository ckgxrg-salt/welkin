{ ... }:
# Minecraft servers
{
  imports = [
    ./login.nix
    ./security.nix
    ./settings.nix

    ./synapse.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Stargazer";
    hostId = "f5bd64b0";
  };

  system.stateVersion = "24.11";
}
