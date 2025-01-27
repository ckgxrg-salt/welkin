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
        localAddress = "192.168.50.101/24";
        localAddress6 = "2408:8215:123:16d0:e251:d8ff:7a13:963e/64";
        config = import ./everpivot;
      };
      # Gitlab
      "archiva" = base // {
        autoStart = false;
        localAddress = "192.168.50.102/24";
        localAddress6 = "2408:8215:123:16d0:e251:d8ff:12ae:d132/64";
        config = import ./everpivot;
      };
      # Minecraft server
      "goatfold" = base // {
        localAddress = "192.168.50.103/24";
        localAddress6 = "2408:8215:123:16d0:e251:d8ff:95ca:72a1/64";
        config = import ./goatfold;
      };
    };
}
