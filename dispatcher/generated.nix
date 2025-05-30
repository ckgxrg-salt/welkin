{ modulesPath, lib, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot = {
    loader.grub.device = "/dev/vda";
    tmp.cleanOnBoot = true;
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "xen_blkfront"
        "vmw_pvscsi"
      ];
      kernelModules = [ "nvme" ];
    };
  };
  zramSwap.enable = true;
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };
  networking = {
    nameservers = [
      "67.207.67.2"
      "67.207.67.3"
    ];
    defaultGateway = "146.190.112.1";
    defaultGateway6 = {
      address = "2604:a880:4:1d0::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          {
            address = "146.190.126.66";
            prefixLength = 20;
          }
          {
            address = "10.48.0.5";
            prefixLength = 16;
          }
        ];
        ipv6.addresses = [
          {
            address = "2604:a880:4:1d0::85b6:3000";
            prefixLength = 64;
          }
          {
            address = "fe80::b4b1:f7ff:fe24:3ec2";
            prefixLength = 64;
          }
        ];
        ipv4.routes = [
          {
            address = "146.190.112.1";
            prefixLength = 32;
          }
        ];
        ipv6.routes = [
          {
            address = "2604:a880:4:1d0::1";
            prefixLength = 128;
          }
        ];
      };
      eth1 = {
        ipv4.addresses = [
          {
            address = "10.124.0.2";
            prefixLength = 20;
          }
        ];
        ipv6.addresses = [
          {
            address = "fe80::68e1:19ff:fe49:2705";
            prefixLength = 64;
          }
        ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="b6:b1:f7:24:3e:c2", NAME="eth0"
    ATTR{address}=="6a:e1:19:49:27:05", NAME="eth1"
  '';
}
