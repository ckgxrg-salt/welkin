{ pkgs, ... }:
# Bootstrap Process
{
  boot = {
    #========== Bootloader ==========#
    # Config systemd-boot
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
      };
    };

    #========== Initrd ==========#
    initrd = {
      systemd.enable = true;
      verbose = true;
      supportedFilesystems = [ "zfs" ];
      availableKernelModules = [
        "virtio_net"
        "virtio_pci"
        "virtio_mmio"
        "virtio_blk"
        "virtio_scsi"
        "9p"
        "9pnet_virtio"
        "ata_piix"
        "uhci_hcd"
        "sr_mod"
        "ahci"
        "sd_mod"
      ];
      kernelModules = [
        "virtio_balloon"
        "virtio_console"
        "virtio_rng"
        "virtio_gpu"
      ];
    };

    #========== Kernel ==========#
    kernelPackages = pkgs.linuxPackages_lqx;

    # ZFS
    supportedFilesystems = [ "zfs" ];

    # Kernel params
    kernelParams = [
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
    ];

    # Kernel extra config
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };

}
