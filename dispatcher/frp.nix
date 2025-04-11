{ ... }:
# Thanks to our f**king GFW, temporarily use frp
{
  services.frp = {
    enable = true;
    role = "server";
    settings = {
      bindPort = 7000;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 7000 ];
  };
}
