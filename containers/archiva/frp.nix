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
          name = "archiva";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 8999;
          remotePort = 7003;
        }
        {
          name = "archiva-ssh";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 22;
          remotePort = 8002;
        }
      ];
    };
  };
}
