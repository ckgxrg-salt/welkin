{ ... }:
# A glance of news
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
}
