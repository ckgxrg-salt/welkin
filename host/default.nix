{ ... }:
# Host entrypoint
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./login.nix
    ./settings.nix
    ./security.nix

    ../backbone
  ];

  networking = {
    hostName = "Welkin";
    hostId = "9ff456c1";
  };

  system.stateVersion = "24.11";
}
