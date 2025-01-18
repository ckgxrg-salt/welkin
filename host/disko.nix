{ ... }:
#========== Disks ==========#
{
  disko.devices = {
    # Physical disks
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
              type = "swap";
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

    # Primary zpool
    zpool = {
      "welkin" = {
        type = "zpool";
        options = {
          cachefile = "none";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
        };
        rootFsOptions = {
          ashift = 12;
          reservation = "1G";
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
          "kvm-images" = {
            type = "zfs_fs";
            mountpoint = "none";
          };
          "kvm-storage" = {
            type = "zfs_fs";
            mountpoint = "/kvm";
          };
        };
      };
    };
  };
}
