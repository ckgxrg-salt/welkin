{ ... }:
{
  services.mealie = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 9275;
    settings = {
      BASE_URL = "https://mealie.welkin.ckgxrg.io";
      DB_ENGINE = "postgres";
      POSTGRES_SERVER = "localhost";

      OIDC_AUTH_ENABLED = true;
      OIDC_SIGNUP_ENABLED = true;
      OIDC_PROVIDER_NAME = "Welkin";
      OIDC_CONFIGURATION_URL = "https://auth.welkin.ckgxrg.io/.well-known/openid-configuration";
      OIDC_CLIENT_ID = "mealie";
      OIDC_AUTO_REDIRECT = true;
      OIDC_ADMIN_GROUP = "admin";
      OIDC_USER_GROUP = "mealie";
    };
    credentialsFile = "/var/secrets/mealie/client-secret.env";
  };

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "mealie";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "mealie" ];
  };
}
