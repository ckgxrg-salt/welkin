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
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  # Only allow Daywatch and Radilopa to access the dom0
  users.users = {
    "akacloud".openssh.authorizedKeys.keyFiles = [
      ../keys/daywatch-ssh.pub
      ../keys/radilopa-ssh.pub
    ];
    "deployer".openssh.authorizedKeys.keyFiles = [
      ../keys/daywatch-ssh.pub
      ../keys/radilopa-ssh.pub
    ];
  };

  # sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;
    extraRules = [
      # Allow remote deployment to use the command without password
      {
        users = [ "deployer" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
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

  # Audit Framework
  security.audit.enable = true;
  security.auditd.enable = true;

  # TPM Support
  boot.initrd.systemd.tpm2.enable = true;
  security.tpm2 = {
    enable = true;
    applyUdevRules = true;
  };
}
