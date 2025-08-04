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
        "xhci_pci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [
        "kvm-intel"
      ];
    };

    #========== Kernel ==========#
    # Use lqx kernel
    kernelPackages = pkgs.linuxPackages_lqx;

    # ZFS
    supportedFilesystems = [ "zfs" ];

    # Kernel extra config
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };
}
