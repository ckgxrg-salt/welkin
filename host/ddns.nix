{ ... }:
{
  users.users."inadyn".extraGroups = [ "secrets" ];

  services.inadyn = {
    enable = true;
    settings = {
      allow-ipv6 = true;
      provider."cloudflare.com" = {
        hostname = "welkin.ckgxrg.io";
        username = "ckgxrg.io";
        include = "/run/secrets/ddns";
        proxied = true;
      };
    };
  };
}
