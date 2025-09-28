{ ... }:
{
  services.adguardhome = {
    enable = false;
    openFirewall = true;
    host = "0.0.0.0";
    port = 3000;
    settings = {
      dhcp.enabled = false;
    };
  };

  networking.firewall = {
    allowedUDPPorts = [
      53
    ];
  };
}
