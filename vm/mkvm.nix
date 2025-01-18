{ nixvirt, pkgs, ... }:
{
  # VM Template
  mkVM =
    {
      name,
      uuid,
      boot,
      mem,
      vcpu,
      disk,
      interface,
    }:
    nixvirt.lib.domain.writeXML {
      type = "kvm";
      inherit name uuid;
      os = {
        type = "hvm";
        firmware = "efi";
        smbios.mode = "sysinfo";
        inherit boot;
      };
      features = {
        acpi = { };
        kvm = { };
      };
      cpu.mode = "host-model";
      vcpu.count = vcpu;
      memory = {
        count = mem;
        unit = "MiB";
      };
      devices = {
        emulator = "${pkgs.qemu}/bin/qemu-system-x86_64";
        inherit disk interface;
        rng = {
          model = "virtio";
          backend = {
            model = "random";
            source = "/dev/urandom";
          };
        };
      };

      # Create pseudo VM information, just for fun
      sysinfo = {
        type = "smbios";
        bios = [
          [
            {
              name = "vendor";
              value = "akaCloud";
            }
            {
              name = "version";
              value = "19.19.810";
            }
            {
              name = "date";
              value = "11/45/14";
            }
          ]
        ];
        system = [
          [
            {
              name = "manufacturer";
              value = "akaCloud";
            }
            {
              name = "product";
              value = "Welkin";
            }
            {
              name = "version";
              value = "11.45.14";
            }
          ]
        ];
      };
    };

}
