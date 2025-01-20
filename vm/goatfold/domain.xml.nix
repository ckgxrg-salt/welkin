{ pkgs }:
# Generate domain.xml
pkgs.writeText "goatfold.xml" ''
  <domain type='kvm'>
    <name>Goatfold</name>
    <uuid>9a74fbbb-8eb8-45d5-b16a-79d4db51e06b</uuid>
    <vcpu>4</vcpu>
    <memory unit='MiB'>8192</memory>
    <os firmware='efi'>
  	  <type>hvm</type>
  	  <smbios mode='sysinfo'/>
  	  <boot dev='cdrom'/>
  	  <boot dev='hd'/>
    </os>
    <features>
  	  <acpi/>
    </features>
    <devices>
  	  <emulator>${pkgs.qemu}/bin/qemu-system-x86_64</emulator>
  	  <rng model='virtio'>
  	    <backend model='random'>/dev/urandom</backend>
  	  </rng>
  	  <disk type='file' device='cdrom'>
  	    <driver name='qemu' type='raw'/>
  	    <source file='/kvm/storage/latest-nixos-minimal-x86_64-linux.iso'/>
  	    <target dev='hdc' bus='ide'/>
  	    <readonly/>
  	  </disk>
  	  <disk type='volume' device='disk'>
  	    <driver name='qemu' type='qcow2' cache='none' discard='unmap'/>
  	    <source pool='images' volume='Goatfold'/>
  	    <target dev='vda' bus='virtio'/>
  	  </disk>
  	  <interface type='bridge'>
  	    <model type='virtio'/>
  	    <source bridge='br0'/>
          <mac address='2e:90:d6:0b:ee:d9'/>
  	  </interface>
    </devices>
  </domain>
''
