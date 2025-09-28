{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7104 ];

  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:7104";
    user = "storage";
    group = "storage";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      options = {
        urAccepted = -1;
        crashReportingEnabled = false;
      };
      gui = {
        # Since it has no native support for SSO...
        insecureAdminAccess = true;
        insecureSkipHostcheck = true;
      };
    };
  };

  # Huh?
  users.users.syncthing = {
    enable = false;
    isSystemUser = true;
    group = "storage";
  };
}
