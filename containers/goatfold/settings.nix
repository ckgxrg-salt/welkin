{ ... }:
# Configuration
{
  #========== Network & Devices ==========#
  # Internet
  networking = {
    # Virtual network...
    wireless.enable = false;
    useNetworkd = true;
    useHostResolvConf = false;

    # IoF
    wg-quick.interfaces = {
      fariof = {
        configFile = "/etc/wireguard/fariof.conf";
        autostart = false;
      };
    };
  };

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.103/24"
            "2408:8215:123:16d0:e251:d8ff:81bc:1da2/64"
          ];
          Gateway = "192.168.50.1";
          DNS = [ "192.168.50.1" ];
          IPv6AcceptRA = true;
          DHCP = "no";
        };
      };
    };
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
