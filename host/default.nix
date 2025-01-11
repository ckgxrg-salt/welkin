{ ... }:
# Host entrypoint
{
  imports = [
    ./boot.nix
    ./login.nix
    ./settings.nix
    ./security.nix
    ./containers
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Welkin";
    hostId = "9ff456c1";
  };

  system.stateVersion = "24.11";
}
