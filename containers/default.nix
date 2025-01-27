{ ... }:
# Containers entrypoint
{
  containers =
    let
      base = {
        autoStart = true;
        privateNetwork = true;
        hostBridge = "br0";
      };
    in
    {
      # Common services
      "everpivot" = base // {
        autoStart = false;
        localAddress = "192.168.50.101/24";
        localAddress6 = "2408:8215:123:16d0:e251:d8ff:95ca:72a1/64";
        config = import ./everpivot;
      };
      # Gitlab
      "archiva" = base // {
        autoStart = false;
        localAddress = "192.168.50.102/24";
        localAddress6 = "2408:8215:123:16d0:e251:d8ff:5bd9:8a1c/64";
        config = import ./archiva;
      };
      # Minecraft server
      "goatfold" = base // {
        localAddress = "192.168.50.103/24";
        localAddress6 = "2408:8215:123:16d0:e251:d8ff:81bc:1da2/64";
        config = import ./goatfold;
      };
    };
}
