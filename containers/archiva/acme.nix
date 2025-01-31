{ ... }:
# SSL Certificates for Gitlab
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "ckgxrg@ckgxrg.io";
      server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
    certs."git.ckgxrg.io" = {
      dnsProvider = "namecheap";
      environmentFile = "/var/lib/secrets/acme";
      dnsPropagationCheck = true;
    };
  };
}
