{ ... }:
# Configuration
{
  # Allow forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  #========== Nix ==========#
  nix = {
    channel.enable = false;
    settings = {
      substituters = [
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
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };

  #========== Miscellaneous ==========#
  # Who'll need this...
  programs.nano.enable = false;
  programs.command-not-found.enable = false;
  services.speechd.enable = false;
  xdg.sounds.enable = false;
  system.tools.nixos-option.enable = false;
  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    doc.enable = false;
    dev.enable = false;
    nixos.enable = false;
  };
}
