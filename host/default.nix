{ ... }:
# Host entrypoint
{
  imports = [
    ./boot.nix
    ./btrfs.nix
    ./fstab.nix
    ./login.nix
    ./settings.nix
    ./security.nix

    ../backbone
  ];

  networking = {
    hostName = "Welkin";
    hostId = "9ff456c1";
  };

  system.stateVersion = "26.11";
}
