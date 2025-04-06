{ ... }:
# Configuration
{
  #========== Hardware ==========#
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  #========== Network & Devices ==========#
  # Internet
  networking = {
    # Ethernet only
    wireless.enable = false;
    useNetworkd = true;
  };

  # Use systemd-networkd to manage interfaces
  systemd.network = {
    enable = true;
    networks = {
      "10-lan" = {
        matchConfig.Name = [
          "enp3s0"
        ];
        networkConfig = {
          Bridge = "br0";
        };
      };
      "10-lan-bridge" = {
        matchConfig.Name = "br0";
        networkConfig = {
          Address = [
            "192.168.50.100/24"
            "2408:8215:123:16d0:e251:d8ff:fe17:c7ff/64"
          ];
          Gateway = "192.168.50.1";
          DNS = [ "192.168.50.1" ];
          IPv6AcceptRA = true;
        };
        linkConfig.RequiredForOnline = "routable";
      };
    };
    netdevs."br0" = {
      netdevConfig = {
        Name = "br0";
        Kind = "bridge";
      };
    };
  };

  #========== Power ==========#
  services.thermald.enable = true;

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

  #========== Localisation ==========#
  # Timezone, Locale
  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
    };
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
