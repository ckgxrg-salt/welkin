{ ... }:
# Miscellaneous services
{
  imports = [
    ./login.nix
    ./security.nix
    ./settings.nix

    ./services/avahi.nix
    ./services/jellyfin.nix
    ./services/radicale.nix
    ./services/samba.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Everpivot";
    hostId = "f058329f";
  };

  system.stateVersion = "24.11";
}
