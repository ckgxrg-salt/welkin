{ ... }:
#========== Disks ==========#
{
  disko.devices = {
    # Physical...? disks
    disk = {
      "vdisk" = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            "ESP" = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };
            "GOATFOLD" = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "goatfold";
              };
            };
          };
        };
      };
    };

    # Primary zpool
    zpool = {
      "goatfold" = {
        type = "zpool";
        options = {
          cachefile = "none";
          ashift = "12";
        };
        rootFsOptions = {
          acltype = "posix";
          compression = "zstd";
          reservation = "1G";
          xattr = "sa";
        };
        mountpoint = "/";

        datasets = {
          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "var" = {
            type = "zfs_fs";
            mountpoint = "/var";
          };
          "mc" = {
            type = "zfs_fs";
            mountpoint = "/srv/minecraft";
          };
        };
      };
    };
  };
}
