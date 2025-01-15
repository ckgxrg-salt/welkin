{ ... }:
# This vm runs Gitlab
{
  imports = [
    ./login.nix
    ./security.nix
    ./settings.nix
    ./tmux.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Archiva";
    hostId = "18324a96";
  };

  system.stateVersion = "24.11";
}
