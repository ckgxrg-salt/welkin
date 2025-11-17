{ ... }:
{
  networking = {
    wireless.enable = false;
    useHostResolvConf = false;
    hosts = {
      "10.7.0.0" = [
        "auth.welkin.ckgxrg.io"
        "Welkin"
      ];
      "10.7.0.1" = [ "Everpivot" ];
      "10.7.0.2" = [ "Archiva" ];
      "10.7.0.3" = [ "Goatfold" ];
      "10.7.0.4" = [ "Stargazer" ];
      "10.7.0.5" = [ "Paralace" ];
    };
  };
  services.resolved.extraConfig = ''
    DNSStubListener=no
  '';

  systemd.network.wait-online.enable = false;

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
  };

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
    };
  };

  users.groups = {
    "secrets".gid = 1437;
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
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
  };

  services.dbus = {
    implementation = "broker";
  };
}
