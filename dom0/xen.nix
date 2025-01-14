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
      memory = 1024;
      maxVCPUs = 2;
      maxMemory = 2048;
    };
    trace = true;
    debug = true;
  };
}
