{ ... }:
{
  disko.devices = {
    disk = {
      "nvme" = {
        type = "disk";
        device = "/dev/nvme0n1";
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
            "SWAP" = {
              size = "32G";
              content = {
                type = "swap";
              };
            };
            "WELKIN" = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "welkin";
              };
            };
          };
        };
      };
    };

    zpool = {
      "welkin" = {
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
          "storage" = {
            type = "zfs_fs";
            mountpoint = "/data";
          };
          "container" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/nixos-containers";
          };
        };
      };
    };
  };
}
