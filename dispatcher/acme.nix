{ ... }:
# SSL Certificates for Gitea
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "ckgxrg@ckgxrg.io";
    };
  };
}
