{ pkgs, ... }:
# Xen entrypoint
{
  # Xen Project Hypervisor
  virtualisation.xen = {
    enable = true;
    efi.bootBuilderVerbosity = "info";
    bootParams = [
      "dom0=pvh"
    ];
    dom0Resources = {
      memory = 1024;
      maxVCPUs = 2;
      maxMemory = 2048;
    };
    #trace = true;
    #debug = true;
  };

  # Just install these vm descriptors
  environment.etc = {
    "guests/goatfold.cfg".text = ''
      name = 'Goatfold'
      type = 'hvm'
      device_model_version = 'qemu-xen'
      device_model_override = '${pkgs.qemu_xen}/bin/qemu-system-i386'
      boot = 'c'
      memory = '8192'
      vcpus = 4
      vif = [ 'mac=2e:90:d6:0b:ee:d9,bridge=xenbr0' ]
      disk = [ '/xen/images/goatfold.qcow2,qcow2,hda,w' ]
    '';
  };
}
