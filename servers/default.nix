{ ckgs, ... }:
{
  containers =
    let
      base = {
        autoStart = true;
        privateNetwork = true;
        hostAddress = "10.7.0.0";
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
        localAddress = "10.7.0.1";
        config = import ./everpivot;
      };
      # Study & Project management
      archiva = base // {
        localAddress = "10.7.0.2";
        config = import ./archiva;
      };
      # Entertainment
      goatfold = base // {
        localAddress = "10.7.0.3";
        config = import ./goatfold;
      };
      # Communication
      stargazer = base // {
        localAddress = "10.7.0.4";
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
        localAddress = "10.7.0.5";
        config = import ./paralace;
      };
    };
}
