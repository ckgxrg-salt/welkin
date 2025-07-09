{ ... }:
let
  mkHost = cfg: {
    useACMEHost = "ckgxrg.io";
    listenAddresses = [
      "[::0]"
    ];
    extraConfig = "encode\n" + cfg;
  };
in
{
  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https disable_certs
      https_port 8443
    '';
    virtualHosts."stargazer.ckgxrg.io" = mkHost ''
      reverse_proxy /_matrix/* 192.168.50.104:8008
    '';
  };

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [
      8443
    ];
    allowedUDPPorts = [
      8443
    ];
  };
}
