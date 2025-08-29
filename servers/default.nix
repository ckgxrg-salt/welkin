{ ckgs, ... }:
{
  containers =
    let
      base = {
        autoStart = true;
        privateNetwork = true;
        hostBridge = "br0";
        specialArgs = { inherit ckgs; };
        timeoutStartSec = "10min";
      };
    in
    {
      # Common services
      everpivot = base // {
        bindMounts = {
          storage = {
            isReadOnly = false;
            mountPoint = "/data";
            hostPath = "/data";
          };
        };
        localAddress = "192.168.50.101/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:95ca:72a1/64";
        config = import ./everpivot;
      };
      # Study & Project management
      archiva = base // {
        localAddress = "192.168.50.102/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:5bd9:8a1c/64";
        config = import ./archiva;
      };
      # Entertainment
      goatfold = base // {
        localAddress = "192.168.50.103/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:81bc:1da2/64";
        config = import ./goatfold;
      };
      # Communication
      stargazer = base // {
        localAddress = "192.168.50.104/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:214e:8251/64";
        specialArgs = { inherit ckgs; };
        config = import ./stargazer;
      };
      # Daily chores
      paralace = base // {
        bindMounts = {
          storage = {
            isReadOnly = false;
            mountPoint = "/data";
            hostPath = "/data";
          };
        };
        localAddress = "192.168.50.105/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:23ae:ea23/64";
        config = import ./paralace;
      };
    };
}
