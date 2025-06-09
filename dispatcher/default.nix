{ modulesPath, ... }:
# Dispatcher entrypoint
{
  imports = [
    ./auth.nix
    ./frp.nix
    ./login.nix
    ./settings.nix
    ./security.nix
    ./services.nix

    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  networking = {
    hostName = "Dispatcher";
    hostId = "7d9bafff";
  };

  system.stateVersion = "24.11";
}
