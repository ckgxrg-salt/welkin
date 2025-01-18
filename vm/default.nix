{ pkgs, nixvirt, ... }:
# VM entrypoint
{
  imports = [ ./mkvm.nix ];

  # Libvirt
  virtualisation.libvirt = {
    enable = true;
    verbose = false;
    swtpm = false;

    # QEMU/KVM Hypervisor
    connections."qemu:///system" = with nixvirt.lib; {
      domains = [
        # Minecraft server
        (mkVM {
          name = "Goatfold";
          uuid = "9a74fbbb-8eb8-45d5-b16a-79d4db51e06b";
          boot = [
            { dev = "cdrom"; }
            { dev = "hd"; }
          ];
          mem = 8192;
          vcpu = 4;
          disk = [
            {
              type = "volume";
              device = "disk";
              driver = {
                name = "qemu";
                type = "qcow2";
                cache = "none";
                discard = "unmap";
              };
              source = {
                pool = "images";
                volume = "Goatfold";
              };
              target = {
                dev = "vda";
                bus = "virtio";
              };
            }
            {
              type = "file";
              device = "cdrom";
              readonly = true;
              driver = {
                name = "qemu";
                type = "raw";
              };
              source.file = "TODO: somewhat.iso";
              target = {
                dev = "hdc";
                bus = "ide";
              };
            }
          ];
          interface = {
            type = "bridge";
            model.type = "virtio";
            source.bridge = "br0";
            mac.address = "2e:90:d6:0b:ee:d9";
          };
        })
      ];

      networks = [
        {
          definition = network.writeXML {
            name = "bridge";
            uuid = "97e8bdf9-56e3-44a4-b339-59ba1d7edaac";
            bridge.name = "br0";
            forward.mode = "bridge";
          };
          active = true;
        }
      ];

      pools = [
        {
          definition = pool.writeXML {
            type = "zfs";
            name = "images";
            uuid = "8a246fbd-2ef0-4a5c-a850-1bf931374d9d";
          };
          active = true;
          restart = false;
          source = {
            device.path = "welkin/kvm-images";
          };
          volumes = [
            (volume.writeXML {
              name = "Goatfold";
              allocation.count = 0;
              capacity = {
                count = 100;
                unit = "GiB";
              };
              target = {
                format = "qcow2";
              };
            })
          ];
        }
      ];
    };
  };

  # Libvirt Daemon
  virtualisation.libvirtd = {
    enable = true;
    sshProxy = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
    parallelShutdown = 3;
    qemu = {
      runAsRoot = false;
      ovmf.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };
}
