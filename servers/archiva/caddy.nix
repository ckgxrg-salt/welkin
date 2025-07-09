{ ... }:
let
  mkHost = cfg: {
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
    virtualHosts."archiva.ckgxrg.io" = mkHost ''
      reverse_proxy 192.168.50.102:8999
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
