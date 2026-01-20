{ pkgs, ... }:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
      };
    };

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

    kernelPackages = pkgs.linuxPackages_zen;

    supportedFilesystems = [ "zfs" ];
    zfs.package = pkgs.zfs_2_4;

    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };
}
