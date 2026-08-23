{ lib, pkgs, ... }:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      limine = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        biosSupport = false;
        style.wallpapers = lib.mkForce [ ];
      };
    };

    zswap = {
      enable = true;
      compressor = "zstd";
    };

    tmp.cleanOnBoot = true;

    initrd = {
      verbose = true;
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

    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };
}
