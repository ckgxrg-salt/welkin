{ ... }:
# Security configuration
{
  # SSH
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    openFirewall = true;

    settings = {
      X11Forwarding = false;
      UsePAM = true;
      PrintMotd = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  # Only allow Daywatch and Radilopa to access the host
  users.users = {
    "cresilexica".openssh.authorizedKeys.keyFiles = [
      ../../misc/daywatch-ssh.pub
      ../../misc/radilopa-ssh.pub
    ];
  };

  # sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };

  # Firewall with NFTables
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
  };

  # AppArmor MAC
  security.apparmor = {
    enable = true;
    enableCache = true;
  };
  services.dbus = {
    apparmor = "enabled";
    implementation = "broker";
  };
}
