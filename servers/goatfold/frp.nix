{ ... }:
# Thanks to our f**king GFW, temporarily use frp
{
  services.frp.settings.proxies = [
    {
      name = "goatfold-ssh";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 22;
      remotePort = 7322;
    }
  ];
}
