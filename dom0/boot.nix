{ pkgs, ... }:
# Bootstrap Process
{
  imports = [ ./fstab.nix ];
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
    # Use Liquorix kernel
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
