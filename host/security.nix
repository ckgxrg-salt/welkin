{ ... }:
{
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

  services.dbus = {
    implementation = "broker";
  };

  boot.initrd.systemd.tpm2.enable = true;
  security.tpm2 = {
    enable = true;
    applyUdevRules = true;
  };
}
