{ ... }:
# Dispatcher entrypoint
{
  imports = [
    ./frp.nix
    ./generated.nix
    ./login.nix
    ./settings.nix
    ./security.nix
    ./services.nix
  ];

  networking = {
    hostName = "IoFCentre";
    hostId = "7d9bafff";
  };

  system.stateVersion = "24.11";
}
