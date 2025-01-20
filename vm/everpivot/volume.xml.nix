pkgs:
# Generate volume.xml
pkgs.writeText "libvirt-volume-everpivot.xml" ''
  <volume>
    <name>Everpivot.qcow2</name>
    <allocation>0</allocation>
    <capacity unit='GiB'>10</capacity>
    <target>
      <format type='qcow2'/>
    </target>
  </volume>
''
