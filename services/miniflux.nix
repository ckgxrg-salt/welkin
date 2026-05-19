{ ... }:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = "/run/secrets/miniflux/client-secret.env";
    config = {
      BASE_URL = "https://welkin.ckgxrg.io/rss";
      LISTEN_ADDR = "127.0.0.1:7503";

      CREATE_ADMIN = 1;

      OAUTH2_OIDC_DISCOVERY_ENDPOINT = "https://welkin.ckgxrg.io/auth/realms/master";
      OAUTH2_CLIENT_ID = "miniflux";
      OAUTH2_OIDC_PROVIDER_NAME = "Welkin";
      OAUTH2_PROVIDER = "oidc";
      OAUTH2_REDIRECT_URL = "https://welkin.ckgxrg.io/rss/oauth2/oidc/callback";
    };
  };

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "miniflux";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "miniflux" ];
  };
}
