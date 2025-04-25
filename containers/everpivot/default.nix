{ ... }:
# Miscellaneous services
{
  imports = [
    ./frp.nix
    ./login.nix
    ./security.nix
    ./settings.nix

    ./services/avahi.nix
    ./services/couchdb.nix
    ./services/glance.nix
    ./services/jellyfin.nix
    ./services/samba.nix
    ./services/shiori.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Everpivot";
    hostId = "f058329f";
  };

  system.stateVersion = "24.11";
}
