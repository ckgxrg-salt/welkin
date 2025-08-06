{ ... }:
{
  users.users."caddy".extraGroups = [ "acme" ];

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "ckgxrg@ckgxrg.io";
    };
    certs = {
      "0" = {
        domain = "ckgxrg.io";
        dnsProvider = "cloudflare";
        environmentFile = "/run/secrets/cloudflare/api";
      };
      "1" = {
        domain = "*.ckgxrg.io";
        dnsProvider = "cloudflare";
        environmentFile = "/run/secrets/cloudflare/api";
      };
      "2" = {
        domain = "*.welkin.ckgxrg.io";
        dnsProvider = "cloudflare";
        environmentFile = "/run/secrets/cloudflare/api";
      };
    };
  };
}
