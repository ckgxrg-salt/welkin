{ modulesPath, ... }:
#========== Filesystem ==========#
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  fileSystems = {
    "/" = {
      device = "welkin/root";
      fsType = "zfs";
    };

    "/nix" = {
      device = "welkin/nix";
      fsType = "zfs";
    };

    "/home" = {
      device = "welkin/home";
      fsType = "zfs";
    };

    "/var" = {
      device = "welkin/var";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/067E-9566";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };
  # Swap
  swapDevices = [
    { device = "/dev/disk/by-uuid/c2641104-e2da-410e-8cc8-30426d5ab182"; }
  ];
}
