{ ... }:
{
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    wireless.iwd.enable = true;
    nftables.enable = true;
    firewall.enable = true;
    hosts = {
      "127.0.0.1" = [
        "welkin.ckgxrg.io"
      ];
    };
  };

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
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
    };
  };

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
