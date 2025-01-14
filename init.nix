{ ... }:
# configuration.nix for initial deployment
# Copy to the domU to use
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = false;
    device = "/dev/xvda";
  };

  networking.hostName = "CHANGEME";
  networking.hostId = "CHANGEME";

  users = {
    users = {
      "akacloud" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
        description = "System administrator";
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkobJTPS3z2n06bkxFbZ0B6RzaR6F8B0cxrwbOVQRuBxWPMGahbIKDjoLlRIzzgjmXfYGJ5jQba5FYoNBZ+PSAxs4R7wJhULQjy9I+SnRUmh/ld76mkhZpNxOnVrQBcFVrP48N8Ku8pNw+FhEfkgEebVJK4tZAp7kOxK53v9MkUCMw46yG0dI87qE72mlLpM1yW82fHMFGReBr2hQ42ONsB1YbRQ66IisCCBGOHVeoFhp05R7T+O3unDOulXiLDIlRz32M88Zh0w82JgeeqylE/tZUhMvdCh0z4tomOKMO2zDuJdJAgjZU3U4KaTp4bXUQ4NQBq3mi0ZhkeiqrIRLH ckgxrg@Daywatch"
        ];
      };
      "deployer" = {
        isNormalUser = true;
        group = "deployer";
        home = "/var/empty";
        createHome = false;
        extraGroups = [ "wheel" ];
        description = "Colmena deployer";
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkobJTPS3z2n06bkxFbZ0B6RzaR6F8B0cxrwbOVQRuBxWPMGahbIKDjoLlRIzzgjmXfYGJ5jQba5FYoNBZ+PSAxs4R7wJhULQjy9I+SnRUmh/ld76mkhZpNxOnVrQBcFVrP48N8Ku8pNw+FhEfkgEebVJK4tZAp7kOxK53v9MkUCMw46yG0dI87qE72mlLpM1yW82fHMFGReBr2hQ42ONsB1YbRQ66IisCCBGOHVeoFhp05R7T+O3unDOulXiLDIlRz32M88Zh0w82JgeeqylE/tZUhMvdCh0z4tomOKMO2zDuJdJAgjZU3U4KaTp4bXUQ4NQBq3mi0ZhkeiqrIRLH ckgxrg@Daywatch"
        ];
      };
    };
    groups = {
      "deployer" = { };
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

  nix = {
    channel.enable = false;
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
