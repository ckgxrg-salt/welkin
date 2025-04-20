{ ... }:
# This vm runs Gitea
{
  imports = [
    ./frp.nix
    ./login.nix
    ./security.nix
    ./settings.nix

    ./glances.nix
    ./gitea.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Archiva";
    hostId = "18324a96";
  };

  system.stateVersion = "24.11";
}
