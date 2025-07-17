{ ... }:
{
  services.v2raya = {
    enable = false;
  };

  services.frp.settings.proxies = [
    {
      name = "v2raya";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 2017;
      remotePort = 7417;
    }
  ];
}
