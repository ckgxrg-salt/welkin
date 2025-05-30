{ pkgs-unstable, ckgs, ... }:
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
      everpivot = base // {
        bindMounts = {
          storage = {
            isReadOnly = false;
            mountPoint = "/data";
            hostPath = "/data";
          };
        };
        specialArgs = { inherit pkgs-unstable ckgs; };
        localAddress = "192.168.50.101/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:95ca:72a1/64";
        config = import ./everpivot;
      };
      # Gitea
      archiva = base // {
        localAddress = "192.168.50.102/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:5bd9:8a1c/64";
        config = import ./archiva;
      };
      # Minecraft server
      goatfold = base // {
        localAddress = "192.168.50.103/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:81bc:1da2/64";
        config = import ./goatfold;
      };
      # Matrix server
      stargazer = base // {
        localAddress = "192.168.50.104/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:214e:8251/64";
        config = import ./stargazer;
      };
      # Nextcloud server
      paralace = base // {
        bindMounts = {
          storage = {
            isReadOnly = false;
            mountPoint = "/var/lib/nextcloud/data/ckgxrg/files";
            hostPath = "/data";
          };
        };
        localAddress = "192.168.50.105/24";
        localAddress6 = "2408:8214:124:1750:e251:d8ff:23ae:ea23/64";
        config = import ./paralace;
      };
    };
}
