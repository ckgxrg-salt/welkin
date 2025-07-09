{ ... }:
{
  sops.secrets."cloudflare" = { };

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
      "ckgxrg.io" = {
        domain = "*.ckgxrg.io";
        dnsProvider = "cloudflare";
        environmentFile = "/run/secrets/cloudflare";
      };
      "welkin.ckgxrg.io" = {
        domain = "*.welkin.ckgxrg.io";
        dnsProvider = "cloudflare";
        environmentFile = "/run/secrets/cloudflare";
      };
    };
  };
}
