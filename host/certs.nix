{ ... }:
{
  users.users."caddy".extraGroups = [ "acme" ];
  containers = {
    "archiva".bindMounts.certs = {
      mountPoint = "/var/lib/acme";
      hostPath = "/var/lib/acme";
    };
    "stargazer".bindMounts.certs = {
      mountPoint = "/var/lib/acme";
      hostPath = "/var/lib/acme";
    };
  };

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
