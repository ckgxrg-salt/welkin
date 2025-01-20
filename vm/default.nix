{ pkgs, ... }:
# VM entrypoint
{
  # Libvirt
  virtualisation.libvirt = {
    enable = true;
    verbose = false;
    swtpm.enable = false;

    # QEMU/KVM Hypervisor
    connections."qemu:///system" = {
      domains = [
        # Minecraft server
        { definition = "${import goatfold/domain.xml.nix pkgs}"; }
      ];

      pools = [
        {
          definition = "${pkgs.writeText "libvirt-pool.xml" ''
            <pool type='dir'>
              <name>images</name>
              <uuid>8a246fbd-2ef0-4a5c-a850-1bf931374d9d</uuid>
              <source>
                <dir path='/kvm/images'/>
              </source>
              <target>
                <path>/kvm/images</path>
              </target>
            </pool>
          ''}";
          active = true;
          volumes = [
            # Goatfold
            { definition = "${import goatfold/volume.xml.nix pkgs}"; }
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
    };
  };
}
