{ ... }:
# Miscellaneous services
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./login.nix
    ./security.nix
    ./settings.nix

    ./services/jellyfin.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Everpivot";
    hostId = "f058329f";
  };

  system.stateVersion = "24.11";
}
