pkgs:
# Generate domain.xml
pkgs.writeText "libvirt-domain-goatfold.xml" ''
  <domain type='kvm'>
    <name>Everpivot</name>
    <uuid>19893bbf-81b1-4fb8-911b-1309fe8dce81</uuid>
    <vcpu>2</vcpu>
    <memory unit='MiB'>2048</memory>
    <os>
      <type>hvm</type>
      <loader readonly='yes' type='pflash'>${pkgs.OVMF.fd}/FV/OVMF_CODE.fd</loader>
      <nvram type='file' template='${pkgs.OVMF.fd}/FV/OVMF_VARS.fd'>
        <source file='/kvm/nvram/Everpivot.fd'/>
      </nvram>
      <smbios mode='sysinfo'/>
      <boot dev='hd'/>
      <boot dev='cdrom'/>
    </os>
    <cpu model='host-model'/>
    <features>
      <acpi/>
    </features>
    <devices>
      <console type='pty'>
        <target type='virtio'/>
      </console>
      <disk type='file' device='cdrom'>
        <source file='/kvm/storage/latest-nixos-minimal-x86_64-linux.iso'/>
        <target dev='hdc' bus='ide'/>
        <readonly/>
      </disk>
      <disk type='volume' device='disk'>
        <driver name='qemu' type='qcow2'/>
        <source pool='images' volume='Everpivot.qcow2'/>
        <target dev='hda' bus='sata'/>
      </disk>
      <interface type='bridge'>
        <model type='virtio'/>
        <source bridge='br0'/>
        <mac address='2e:90:d6:0b:ee:d9'/>
      </interface>
    </devices>
    <sysinfo type='smbios'>
      <bios>
        <entry name="vendor">akaCloud</entry>
        <entry name="version">4.23</entry>
        <entry name="date">5/6/47</entry>
      </bios>
      <system>
        <entry name="manufacturer">BSE</entry>
        <entry name="product">Everpivot</entry>
        <entry name="version">23.12</entry>
      </system>
    </sysinfo>
  </domain>
''
