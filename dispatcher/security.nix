{ ... }:
# Security configuration
{
  # SSH to the dom0 should be strictly limited
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    openFirewall = true;

    settings = {
      X11Forwarding = false;
      UsePAM = true;
      PrintMotd = true;
      PasswordAuthentication = false;
    };
  };
  # Only allow Daywatch and Radilopa to access
  users.users = {
    "elekiana".openssh.authorizedKeys.keyFiles = [
      ../keys/daywatch-ssh.pub
      ../keys/radilopa-ssh.pub
    ];
    "root".openssh.authorizedKeys.keyFiles = [
      ../keys/daywatch-ssh.pub
      ../keys/radilopa-ssh.pub
    ];
  };

  # sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
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

  # Audit Framework
  security.audit.enable = true;
  security.auditd.enable = true;
}
