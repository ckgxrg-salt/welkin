{ ... }:
{
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
  services.sanoid = {
    enable = true;
    templates."default" = {
      autosnap = true;
      autoprune = true;
      hourly = 24;
      daily = 7;
      weekly = 4;
      monthly = 4;
    };
    datasets = {
      "welkin/storage".useTemplate = [ "default" ];
      "welkin/container".useTemplate = [ "default" ];
    };
  };

  networking = {
    wireless.iwd.enable = true;
    nftables.enable = true;
    firewall.enable = true;

    # Control container IPs
    nat = {
      enable = true;
      internalInterfaces = [ "ve-*" ];
      externalInterface = "wlan0";
    };
  };

  services.thermald.enable = true;

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

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
    };
  };

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
