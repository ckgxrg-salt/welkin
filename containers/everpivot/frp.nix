{ ... }:
# Thanks to our f**king GFW, temporarily use frp
{
  services.frp = {
    enable = true;
    role = "client";
    settings = {
      serverAddr = "welkin.ckgxrg.io";
      serverPort = 7000;
      proxies = [
        {
          name = "jellyfin";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 8096;
          remotePort = 7004;
        }
        {
          name = "alumnimap";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 8080;
          remotePort = 7078;
        }
        {
          name = "shiori";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 8089;
          remotePort = 7007;
        }
        {
          name = "glances";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 61208;
          remotePort = 7010;
        }
        {
          name = "glance";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 5678;
          remotePort = 7011;
        }
      ];
    };
  };
}
