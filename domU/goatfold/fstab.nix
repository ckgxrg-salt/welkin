{ modulesPath, ... }:
#========== Filesystem ==========#
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  fileSystems = {
    "/" = {
      device = "goatfold/root";
      fsType = "zfs";
    };

    "/nix" = {
      device = "goatfold/nix";
      fsType = "zfs";
    };

    "/var" = {
      device = "goatfold/var";
      fsType = "zfs";
    };

    "/srv" = {
      device = "goatfold/srv";
      fsType = "zfs";
    };
  };
}
