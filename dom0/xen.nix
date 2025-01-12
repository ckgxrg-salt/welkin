{ ... }:
# The Xen Project Hypervisor
{
  virtualisation.xen = {
    enable = true;
    efi.bootBuilderVerbosity = "info";
    bootParams = [
      "dom0=pvh"
    ];
    dom0Resources = {
      memory = 512;
      maxVCPUs = 2;
      maxMemory = 1024;
    };
  };
}
