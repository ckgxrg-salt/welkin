{ lib, ... }:
let
  mkSubvol =
    name: value:
    value
    // {
      device = "/dev/disk/by-partlabel/root";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
        "subvol=${name}"
      ];
    };
in
{
  fileSystems = {
    "esp" = {
      device = "/dev/disk/by-partlabel/esp";
      fsType = "vfat";
      mountPoint = "/boot";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  }
  // (lib.attrsets.mapAttrs mkSubvol {
    "rootfs".mountPoint = "/";
    "data".mountPoint = "/data";
    "config".mountPoint = "/var/lib";
    "log".mountPoint = "/var/log";
    "cache".mountPoint = "/var/cache";
    "nix".mountPoint = "/nix";
  });

  swapDevices = [
    {
      device = "/dev/disk/by-partlabel/swap";
    }
  ];
}
