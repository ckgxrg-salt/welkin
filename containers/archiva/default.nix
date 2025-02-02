{ ... }:
# This vm runs Gitea
{
  imports = [
    ./login.nix
    ./security.nix
    ./settings.nix

    ./acme.nix
    ./gitea.nix
    ./nginx.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Archiva";
    hostId = "18324a96";
  };

  system.stateVersion = "24.11";
}
