{ ... }:
# Host entrypoint
{
  imports = [
    ./acme.nix
    ./frp.nix
    ./generated.nix
    ./login.nix
    ./settings.nix
    ./security.nix
    ./services.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "IoFCentre";
    hostId = "7d9bafff";
  };

  system.stateVersion = "24.11";
}
