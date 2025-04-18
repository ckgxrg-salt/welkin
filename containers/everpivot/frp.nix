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
          name = "couchdb";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 5984;
          remotePort = 7006;
        }
      ];
    };
  };
}
