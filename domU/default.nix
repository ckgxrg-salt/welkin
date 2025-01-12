{ ... }:
# Xen entrypoint
{
  virtualisation.xen = {
    enable = true;
    efi.bootBuilderVerbosity = "info";
    dom0Resources = {
      memory = 512;
      maxVCPUs = 2;
      maxMemory = 1024;
    };
  };
  containers = {
    # Common services
    "everpivot" = {
      autoStart = true;
      privateNetwork = true;
      hostBridge = "br0";
      localAddress = "192.168.50.101/24";
      localAddress6 = "2408:8215:123:16d0:e251:d8ff:95ca:72a1/64";
      config = import ./everpivot;
    };
    # Gitlab
    "archiva" = {
      autoStart = true;
      privateNetwork = true;
      hostBridge = "br0";
      localAddress = "192.168.50.102/24";
      localAddress6 = "2408:8215:123:16d0:e251:d8ff:5bd9:8a1c/64";
      config = import ./archiva;
    };
    # Minecraft server
    "goatfold" = {
      autoStart = true;
      privateNetwork = true;
      hostBridge = "br0";
      localAddress = "192.168.50.103/24";
      localAddress6 = "2408:8215:123:16d0:e251:d8ff:81bc:1da2/64";
      config = import ./goatfold;
    };
  };
}
