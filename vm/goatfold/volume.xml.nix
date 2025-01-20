pkgs:
# Generate volume.xml
pkgs.writeText "libvirt-volume-goatfold.xml" ''
  <volume>
    <name>Goatfold.qcow2</name>
    <allocation>0</allocation>
    <capacity unit='GiB'>100</capacity>
    <target>
      <format>qcow2</format>
    </target>
  </volume>
''
