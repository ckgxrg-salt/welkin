{ ... }:
# A simple dashboard
{
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        host = "127.0.0.1";
        port = 5678;
      };
    };
  };

  services.frp.settings.proxies = [
    {
      name = "glance";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 5678;
      remotePort = 7011;
    }
  ];
}
