{ ... }:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = "/var/secrets/miniflux/client-secret.env";
    config = {
      BASE_URL = "https://welkin.ckgxrg.io/miniflux";
      LISTEN_ADDR = "127.0.0.1:9124";

      CREATE_ADMIN = 1;

      OAUTH2_OIDC_DISCOVERY_ENDPOINT = "https://auth.welkin.ckgxrg.io";
      OAUTH2_CLIENT_ID = "miniflux";
      OAUTH2_OIDC_PROVIDER_NAME = "Welkin";
      OAUTH2_PROVIDER = "oidc";
      OAUTH2_REDIRECT_URL = "https://welkin.ckgxrg.io/miniflux/oauth2/oidc/callback";
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

  services.frp.settings.proxies = [
    {
      name = "miniflux";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 9124;
      remotePort = 7503;
    }
  ];
}
